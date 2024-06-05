-- lua/config/toggleterm.lua
local M = {}

M.setup = function()
    require('toggleterm').setup{
        size = 20,
        open_mapping = [[<c-t>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = false,
        start_in_insert = true,
        persist_size = true,
        direction = 'float',
        shell = vim.o.shell,
    }
end

return M

