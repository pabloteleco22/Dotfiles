local function go_top()
    local topline = vim.fn.line("w0")
    vim.api.nvim_win_set_cursor(0, { topline, 0 })
end

local function center_window()
    vim.cmd("normal! zz")
end

local function go_to_parent(state)
    require("neo-tree.ui.renderer")
        .focus_node(state, state.tree:get_node():get_parent_id())
end

local function open_or_show(state)
    local node = state.tree:get_node()

    if require("neo-tree.utils").is_expandable(node) then
        state.commands["toggle_node"](state)
    else
        state.commands['open'](state)
        vim.cmd('Neotree reveal')
    end
end

require("neo-tree").setup({
    filesystem = {
        window = {
            mappings = {
                ["H"] = {
                    go_top,
                    desc = "Go to the top of the window"
                },
                ["I"] = "toggle_hidden",
                ["z"] = false,
                ["zz"] = {
                    center_window,
                    desc = "Center the window over the cursor"
                },
                ["[z"] = {
                    go_to_parent,
                    desc = "Go to parent node"
                },
                ["<space>"] = {
                    open_or_show,
                    desc = "Open the node if is a directory, show it otherwise"
                }
            }
        },
    }
})
