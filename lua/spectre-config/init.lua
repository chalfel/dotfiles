require('spectre').setup({
	live_update = false,
})

vim.keymap.set('n', '<leader>sf', '<cmd>lua require("spectre").open()<CR>', {
	desc = "Open Spectre"
})
vim.keymap.set('n', '<leader>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file"
})
