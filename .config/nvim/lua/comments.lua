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

vim.api.nvim_create_user_command('CommentSyntaxAdd',
    function(opts)
        if #opts.fargs ~= 2 then
            vim.notify("CommentSyntaxAdd requiere exactamente 2 argumentos", vim.log.levels.ERROR)
            return
        end
        local file_ext = "*" .. opts.fargs[1]
        local comment_str = opts.fargs[2]:gsub('/', '\\/') .. " "
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

                        local pattern = vim.regex("^" .. comment_str)
                        local line = vim.api.nvim_get_current_line()

                        local start_pos = vim.fn.getpos(".")
                        local end_pos = vim.fn.getpos("v")

                        local start_line = start_pos[2]
                        local end_line = end_pos[2]

                        if start_line > end_line then
                          start_line, end_line = end_line, start_line
                        end

                        for lnum = start_line, end_line do
                            if pattern:match_str(line) then
                                pcall(function()
                                    vim.cmd(lnum .. "s/^" .. comment_str .. "//")
                                end)
                            else
                                pcall(function()
                                    vim.cmd(lnum .. "s/^/" .. comment_str .. "/")
                                end)
                            end
                        end
                        vim.fn.setreg('/', previous_search_pattern)
                        vim.cmd("noh")
                    end

                    vim.keymap.set(
                        'n',
--                         '<leader>/',
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
