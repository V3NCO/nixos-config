if not nixCats('general') then
    return
end

-- Disable netrw (using nvim-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-web-devicons").setup()
require("nvim-tree").setup({
    update_focused_file = { enable = true },
    actions = {
        open_file = {
            quit_on_open = true
        }
    }
})

vim.keymap.set("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true, desc = "Toggle NvimTree" })
