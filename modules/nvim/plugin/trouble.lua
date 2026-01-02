if not nixCats('general') then
  return
end

require("trouble").setup {}

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
  { silent = true, noremap = true, desc = "Trouble Diagnostics" })
