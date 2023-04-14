print("Welcome Caio! How are you doing today?")

vim.g.mapleader = " "

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.cmd([[ set clipboard=unnamedplus ]])

require("packer").startup(function(use)
	use { "wbthomason/packer.nvim" }
	use { "ellisonleao/gruvbox.nvim" }
	use { "zbirenbaum/copilot.lua" }
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end
	}
	use { "hashivim/vim-terraform" }
	use { 'mfussenegger/nvim-dap' }
	use "folke/neodev.nvim"
	use { "tpope/vim-surround" }
	use { 'tpope/vim-fugitive' }
	use { 'terryma/vim-multiple-cursors' }
	use { 'nvim-telescope/telescope-dap.nvim' }
	use { 'mfussenegger/nvim-dap-python' } -- Python
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use { "fatih/vim-go" }
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			{ 'neovim/nvim-lspconfig' },    -- Required
			{ 'williamboman/mason.nvim' },  -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional
			{ 'hrsh7th/nvim-cmp' },         -- Required
			{ 'hrsh7th/cmp-nvim-lsp' },     -- Required
			{ 'hrsh7th/cmp-buffer' },       -- Optional
			{ 'hrsh7th/cmp-path' },         -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' },     -- Optional
			{ 'L3MON4D3/LuaSnip' },         -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		},

		use { "akinsho/toggleterm.nvim", tag = '*' },
		use "jhlgns/naysayer88.vim",
		use "terrortylor/nvim-comment",
		use "CreaturePhil/vim-handmade-hero",
		use "jay-babu/mason-nvim-dap.nvim"

	}
end)
require("mason-nvim-dap").setup({
	automatic_setup = true,
})
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

require("dapui").setup()
require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	mapping = {
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),
		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
	}
})

-- some
vim.keymap.set("n", "<M-b>", ":Ex<CR>")

-- split screen and navigation
vim.keymap.set("n", "<leader>v", ":vsplit<CR><C-w>l", { noremap = true })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { noremap = true })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { noremap = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { noremap = true })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { noremap = true })
vim.keymap.set("n", "<leader>l", "$", { noremap = true })
vim.keymap.set("n", "<leader>h", "_", { noremap = true })


-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>p', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<M-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


-- TREESITTER
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "vim", "go", "javascript", "typescript", "rust" },
	highlight = {
		enable = true,
	}
}

-- GRUVBOX
require("gruvbox").setup({
	contrast = "hard",
	palette_overrides = {
		gray = "#2ea542",
	}
})

-- LUALINE
require("lualine").setup {
	options = {
		icons_enabled = false,
		theme = "onedark",
		component_separators = "|",
		section_separators = "",
	},
}

-- LSP
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"gopls",
	"eslint",
	"rust_analyzer",
})

lsp.set_preferences({
	sign_icons = {}
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
end)

lsp.setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = false,
		virtual_text = true,
		underline = false,
	}
)

-- COMMENT
require("nvim_comment").setup({
	operator_mapping = "<leader>/"
})

-- TERMINAL SETUP
require("toggleterm").setup {
	direction = "horizontal",
	size = 15,
	open_mapping = [[<leader>j]]
}

-- COLORSCHEME
vim.cmd("colorscheme gruvbox")
-- Adding the same comment color in each theme
vim.cmd([[
	augroup CustomCommentCollor
		autocmd!
		autocmd VimEnter * hi Comment guifg=#2ea542
	augroup END
]])

-- Disable annoying match brackets and all the jaz
vim.cmd([[
	augroup CustomHI
		autocmd!
		autocmd VimEnter * NoMatchParen
	augroup END
]])

vim.keymap.set('n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

vim.o.background = "dark"

vim.keymap.set("i", "jj", "<Esc>")

vim.opt.guicursor = "i:block"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.swapfile = false

vim.o.hlsearch = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
--vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

require('telescope').load_extension('dap')


local dap = require "dap"

dap.adapters.node2 = {
	type = "executable",
	command = "node-debug2-adapter",
	args = {}
}

local currentMochaTest =
{
	type = 'node2',
	request = 'launch',
	name = 'Current Mocha Test',
	program = '${workspaceFolder}/node_modules/mocha/bin/_mocha',
	args = {
		'-u',
		'bdd',
		'--require',
		'${workspaceFolder}/test/setup.js',
		'--reporter',
		'dot',
		'--timeout',
		'999999',
		'--colors',
		'${file}'
	},
	internalConsoleOptions = 'openOnSessionStart',
	runtimeVersion = '14.15.5',
}

local nodemonRun = {
	type = "node2",
	request = "launch",
	name = "nodemon",
	runtimeExecutable = "nodemon",
	program = "${workspaceFolder}/server.js",
	restart = true,
	runtimeVersion = "14.15.5"
}
dap.configurations.javascript = {
	currentMochaTest,
	nodemonRun,
}

dap.adapters.go = function(callback, config)
	local handle
	local pid_or_err
	local port = 38697
	handle, pid_or_err =
		vim.loop.spawn(
			"dlv",
			{
				args = { "dap", "-l", "127.0.0.1:" .. port },
				detached = true
			},
			function(code)
				handle:close()
				print("Delve exited with exit code: " .. code)
			end
		)
	----should we wait for delve to start???
	--vim.defer_fn(
	--function()
	--dap.repl.open()
	--callback({type = "server", host = "127.0.0.1", port = port})
	--end,
	--100)
	dap.repl.open()
	callback({ type = "server", host = "127.0.0.1", port = port })
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}"
	}
}

--local utils = require('utils')
vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>')
vim.keymap.set('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
vim.keymap.set('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
vim.keymap.set('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
vim.keymap.set('n', '<leader>dt', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
vim.keymap.set('n', '<leader>dsbm',
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
vim.keymap.set('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
vim.keymap.set('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

-- -- telescope-dap
vim.keymap.set('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
vim.keymap.set('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
vim.keymap.set('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
vim.keymap.set('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
vim.keymap.set('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
local namespace = vim.api.nvim_create_namespace("dap-hlng")



vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })



-- vim.fn.sign_define('DapBreakpoint', { text =  '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpoint', {
	text = '',
	texthl = 'DapBreakpoint',
	linehl = '',
	numhl = 'DapBreakpoint'
})

vim.fn.sign_define('DapBreakpointCondition',
	{ text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',
	{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

vim.g.multi_cursor_start_word_key = 'gb'
vim.g.multi_cursor_next_key = 'gb'
vim.g.multi_cursor_select_all_word_key = 'ga'
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_format_on_save = function(bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd('BufWritePre', {
		group = augroup,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format()
			filter = function(client)
				return client.name == "null-ls"
			end
		end,
	})
end

vim.keymap.set('n', '<leader>de', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)

vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end)
vim.keymap.set('n', '<leader>dh', function() require("dapui").float_element() end)
vim.keymap.set('n', '<leader>dv', function() require("dapui").eval() end)

local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
	lsp_format_on_save(bufnr)
end)
