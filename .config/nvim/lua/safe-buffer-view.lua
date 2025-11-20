local views = {}

vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        views[bufnr] = vim.fn.winsaveview()
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        if views[bufnr] then
            vim.fn.winrestview(views[bufnr])
        end
    end
})
