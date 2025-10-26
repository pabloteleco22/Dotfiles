vim.api.nvim_create_user_command('CommentSyntaxMapping',
    function(opts)
        if #opts.fargs ~= 1 then
            vim.notify("CommentSyntaxMapping requiere exactamente 1 argumentos", vim.log.levels.ERROR)
            return
        end

        CommentSyntaxMappingStr = opts.fargs[1]

        vim.keymap.set(
            'n',
            CommentSyntaxMappingStr,
            [[<Nop>]]
        )
        vim.keymap.set(
            'v',
            CommentSyntaxMappingStr,
            [[<Nop>]]
        )
    end,
    { nargs = 1 }
)

local function remove_comment(lnum, pattern_str)
    pcall(function()
        vim.cmd(lnum .. "s/" .. pattern_str .. "//")
    end)
end

local function add_comment(lnum, comment_str)
    vim.api.nvim_buf_set_text(0, lnum - 1, 0, lnum - 1, 0, { comment_str .. ' ' })
end

vim.api.nvim_create_user_command('CommentSyntaxAdd',
    function(opts)
        if #opts.fargs ~= 2 then
            vim.notify("CommentSyntaxAdd requiere exactamente 2 argumentos", vim.log.levels.ERROR)
            return
        end
        local file_ext = "*" .. opts.fargs[1]
        local comment_str = opts.fargs[2]
        local default_syntax_mapping_str = '<leader>/'
        local group = vim.api.nvim_create_augroup('CommentSyntaxGroup_' .. file_ext, { clear = true })

        vim.api.nvim_create_autocmd(
            { 'BufReadPre' },
            {
                group = group,
                pattern = { file_ext },
                callback = function()
                    local function toggle_comment()
                        local previous_search_pattern = vim.fn.getreg('/')

                        local pattern_str = "^[[:blank:]]*" .. comment_str:gsub('/', '\\/') .. [[ \?]]
                        local pattern = vim.regex(pattern_str)
                        local line = vim.api.nvim_get_current_line()

                        local start_pos = vim.fn.getpos(".")
                        local end_pos = vim.fn.getpos("v")

                        local start_line = start_pos[2]
                        local end_line = end_pos[2]

                        if start_line > end_line then
                            start_line, end_line = end_line, start_line
                        end

                        local action = "add"
                        if pattern:match_str(line) then
                            action = "remove"
                        end

                        for lnum = start_line, end_line do
                            if action == "remove" then
                                remove_comment(lnum, pattern_str);
                            elseif action == "add" then
                                add_comment(lnum, comment_str);
                            end
                        end
                        vim.fn.setreg('/', previous_search_pattern)
                        vim.cmd("noh")
                    end

                    vim.keymap.set(
                        'n',
                        CommentSyntaxMappingStr ~= nil and CommentSyntaxMappingStr or default_syntax_mapping_str,
                        toggle_comment,
                        { buffer = 0 }
                    )

                    vim.keymap.set(
                        'v',
                        CommentSyntaxMappingStr ~= nil and CommentSyntaxMappingStr or default_syntax_mapping_str,
                        toggle_comment,
                        { buffer = 0 }
                    )
                end,
            }
        )
    end,
    { nargs = '+' }
)
