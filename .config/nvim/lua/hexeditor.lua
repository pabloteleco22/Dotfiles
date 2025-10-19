local api = vim.api
local bo = vim.bo
local fn  = vim.fn
local cmd = vim.cmd

local Hex = {
    last_ftype = {},
    last_fenc = {},
    last_eol = {},
    binary_view = {},
    hex_view = {},
    COMMAND = [[xxd -u -g1 ]]
}

function Hex.make_augroup_name(bufnr)
    return "HexToggleBuf" .. tostring(bufnr)
end

function Hex.enter_hex(bufnr, cols)
    bufnr = bufnr or api.nvim_get_current_buf()
    Hex.binary_view[bufnr] = fn.winsaveview()
    bo[bufnr].binary = true
    Hex.last_ftype[bufnr] = bo[bufnr].filetype
    Hex.last_fenc[bufnr] = bo[bufnr].fileencoding
    Hex.last_eol[bufnr] = bo[bufnr].eol
    bo[bufnr].filetype = "xxd"
    bo[bufnr].fileencoding = "latin1"
    bo[bufnr].eol = false
    cmd([[silent %!]] .. Hex.COMMAND .. [[ -c]] .. cols)
    bo[bufnr].modified = false
    cmd('redraw')

    local pre_saving_view = fn.winsaveview()

    local group = Hex.make_augroup_name(bufnr)
    api.nvim_create_augroup(group, { clear = true })

    api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = bufnr,
        callback = function()
            pre_saving_view = fn.winsaveview()
            bo[bufnr].binary = false

            local untree = fn.undotree()
            local undojoin_str = [[]]
            if untree.seq_cur == untree.seq_last then
                undojoin_str = [[undojoin | ]]
            end

            cmd([[silent ]] .. undojoin_str .. [[%!]] .. Hex.COMMAND .. [[ -r -c]] .. cols)
            bo[bufnr].binary = true
        end,
    })

    api.nvim_create_autocmd("BufWritePost", {
        group = group,
        buffer = bufnr,
        callback = function()
            cmd([[silent undojoin | %!]] .. Hex.COMMAND .. [[ -c]] .. cols)
            bo[bufnr].modified = false
            fn.winrestview(pre_saving_view)
            cmd('redraw')
        end,
    })

    if Hex.hex_view[bufnr] ~= nil then
        fn.winrestview(Hex.hex_view[bufnr])
    end
end

function Hex.leave_hex(bufnr, cols)
    bufnr = bufnr or api.nvim_get_current_buf()
    Hex.hex_view[bufnr] = fn.winsaveview()
    bo[bufnr].binary = false
    cmd([[silent %!]] .. Hex.COMMAND .. [[ -r -c]] .. cols)
    bo[bufnr].filetype = Hex.last_ftype[bufnr]
    bo[bufnr].fileencoding = Hex.last_fenc[bufnr]
    bo[bufnr].eol = Hex.last_eol[bufnr]
    bo[bufnr].modified = false
    cmd('redraw')

    local group = Hex.make_augroup_name(bufnr)
    pcall(api.nvim_del_augroup_by_name, group)

    if Hex.binary_view[bufnr] ~= nil then
        fn.winrestview(Hex.binary_view[bufnr])
    end
    cmd('redraw')
end

function Hex.ToggleHex(opts)
    local bufnr = api.nvim_get_current_buf()
    local ft = bo[bufnr].filetype or ""

    local cols = 16

    if #opts.fargs >= 1 then
        cols = math.floor(tonumber(opts.fargs[1]) or cols)
    end

    if ft == "xxd" then
        Hex.leave_hex(bufnr, cols)
        vim.notify("Hex -> Bin", vim.log.levels.INFO)
    else
        Hex.enter_hex(bufnr, cols)
        vim.notify("Bin -> Hex", vim.log.levels.INFO)
    end
end

api.nvim_create_user_command("HexToggle", Hex.ToggleHex, { nargs = '*' })

api.nvim_create_user_command("HexToggle", Hex.ToggleHex, { nargs = '*' })
