require("neo-tree").setup({
    filesystem = {
        window = {
            mappings = {
                ["H"] = function()
                    local topline = vim.fn.line("w0")
                    vim.api.nvim_win_set_cursor(0, { topline, 0 })
                end,
                ["I"] = function(state)
                    print(vim.inspect(state.commands.toggle_hidden))
                    state.commands.toggle_hidden(state)
                end,
                ["z"] = function()
                    vim.cmd("normal! zz")
                end
            }
        }
    }
})
