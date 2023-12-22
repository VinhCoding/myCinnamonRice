-- vim.tbl_extend('keep', lvim.builtin.lualine.sections.lualine_a, { "filename" })
-- lvim.builtin.lualine.sections.lualine_a = { "filename" }
--
--
vim.tbl_extend('keep', lvim.builtin.lualine.sections.lualine_a, { "filename", path = 2, })
lvim.builtin.lualine.sections.lualine_a = { { 'filename', path = 2, } }
