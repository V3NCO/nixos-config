-- Add these settings from headblockhead's config:

vim.opt.autoindent = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.tabstop = 2

-- Move the preview screen
vim.opt.splitbelow = true

-- Enable undo and swap file
vim.opt.undofile = true
vim.opt.swapfile = true

-- Use system clipboard
vim.opt.clipboard:append('unnamedplus')

-- Disable swap/backup for gopass files (security)
vim.cmd("au BufNewFile,BufRead /dev/shm/gopass. * setlocal noswapfile nobackup noundofile")
