local renderer = require("neo-tree.ui.renderer")

local function go_to_parent(state)
    renderer.focus_node(state, state.tree:get_node():get_parent_id())
end

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
                ["zz"] = function()
                    vim.cmd("normal! zz")
                end,
                ["[z"] = function(state)
                    go_to_parent(state)
                end,
            }
        }
    }
})