vim.api.nvim_create_user_command('SafePaste',
    function()
        local reg_value = vim.fn.getreg("")
        vim.cmd([[normal! p]])
        vim.fn.setreg("", reg_value)
    end,
    {}
)
