reload("user.plugins")
reload("user.colorscheme")

-- reload('user.options')
-- reload('user.keymaps')
-- reload('user.which-key')
-- reload('user.statusline')
-- reload('user.lsp')
-- reload('user.dashboard')
-- reload('user.autocmds')
-- reload('user.lsp-status')

-- Verk Vim.Config : BEGIN
vim.api.nvim_buf_get_name(0)
vim.opt.relativenumber = true
-- Verk Vim.Config : END

-- Verk UI.Config : BEGIN
lvim.colorscheme =  "gruvbox"
vim.opt.nu = true
vim.relativenumber = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
-- Verk UI.Config : END
