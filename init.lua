print("Welcome Caio! How are you doing today?")

vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeFlags = 'gI'

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.cmd([[ set clipboard=unnamedplus ]])
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' }, { "APZelos/blamer.nvim" },
	{ "tpope/vim-surround" },
	{ "ntk148v/vim-horizon" },
	{
		"terrortylor/nvim-comment"
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{ "ThePrimeagen/harpoon" },
	{ "camgraff/telescope-tmux.nvim" },
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {} -- this is equalent to setup({}) function
	},
	{ "nvim-tree/nvim-tree.lua" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "nvim-pack/nvim-spectre" },
	{ "zbirenbaum/copilot.lua" },
	{ "zbirenbaum/copilot-cmp" },
	{ 'echasnovski/mini.surround' },
	{ "hashivim/vim-terraform" },
	{ "folke/neodev.nvim" },
	{ "tpope/vim-surround" },
	{ 'tpope/vim-fugitive' },
	{ 'mg979/vim-visual-multi',          branch = 'master',  lazy = false },
	{ "nvim-tree/nvim-web-devicons" },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{
		'nvim-telescope/telescope.nvim',
		version = '0.1.1',
		dependencies = {
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-lua/plenary.nvim' }
		},
		config = function()
			require('telescope').load_extension('fzf')
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
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
	},

	"terrortylor/nvim-comment",

	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{ 'buoto/gotests-vim' },
	{
		"mg979/vim-visual-multi"
	}

}
)
-- Load Telescope
local telescope = require('telescope')

-- Set Telescope options
telescope.setup({
	defaults = {
		file_ignore_patterns = { 'node_modules' },
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,          -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	}
})


vim.api.nvim_set_keymap('n', '<leader>fa',
	[[<cmd>lua require('telescope.builtin').find_files({prompt_title = 'All files', hidden = true, follow = true, find_command = {'fd', '-t', 'f', '-H', '-L', '--no-ignore-vcs'}})<CR>]],
	{ noremap = true, silent = true })



--require("neodev").setup()

require("nvim-tree").setup({
	git = {
		ignore = false,
	},
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
vim.keymap.set('n', '<leader>f', "<cmd>lua vim.lsp.buf.format()<CR>")

vim.keymap.set('n', '<leader>p', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<M-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
--vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sl', require('telescope.builtin').git_commits, { desc = '[S]earch Git [L]og' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').git_status, { desc = '[S]earch Git [S]tatus' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch by [K]eymap' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>st', [[<cmd>TodoTelescope<CR>]], { desc = '[S]earch [T]odo' })
vim.keymap.set('n', '<leader>e', "<cmd>NvimTreeFindFileToggle<CR>", { desc = '[N]erdTree [F]indToggle' })


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

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('ufo').setup()

-- LSP
local lsp = require("lsp-zero")

lsp.preset('recommended')


lsp.set_preferences({
	sign_icons = {}
})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		async = true,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format_on_save = function(client, bufnr)
	if (client.name == "eslint") then
		vim.cmd('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll')
		return
	end

	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
	end

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

lsp.on_attach(function(client, bufnr)
	format_on_save(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	lsp.default_keymaps({ buffer = bufnr })
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
end)

lsp.set_server_config({
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}
		}
	}
})

lsp.setup()


require("mason").setup()
require('mason-lspconfig').setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = { 'tsserver', 'rust_analyzer' },
	handlers = {
		lsp.default_setup,
	},
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = false,
		virtual_text = true,
		underline = false,
	}
)

--TERMINAL SETUP

-- COLORSCHEME
vim.cmd("colorscheme gruvbox")
--vim.cmd("colorscheme horizon")
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

vim.keymap.set('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

vim.o.background = "dark"

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "<C-c>", "<Esc>")

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


local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns

local lsp = require('lsp-zero')

require('copilot').setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
	formatters = {
		label = require("copilot_cmp.format").format_label_text,
		insert_text = require("copilot_cmp.format").format_insert_text,
		preview = require("copilot_cmp.format").deindent,
	},
})

require('copilot_cmp').setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

vim.g.copilot_filetypes = {
	["*"] = true,
}
cmp.setup({
	mapping = {
		-- `Enter` key to confirm completion
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
		['<CR>'] = cmp.mapping.confirm({
			select = false,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),
		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
	},
	sources = {
		{ name = 'copilot' },
		{ name = 'nvim_lsp' },
	},
})



-- lsp.on_attach(function(client, bufnr)
-- 	lsp_format_on_save(bufnr)
-- end)

local dart_lsp = lsp.build_options('dartls', {})

local keymap = vim.keymap.set
local silent = { silent = true }
keymap("n", "H", "^", silent)
keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
keymap("x", "J", ":move '>+1<CR>gv-gv", silent)
keymap("n", "<CR>", ":noh<CR><CR>", silent)
keymap("n", "<Tab>", ":BufferNext<CR>", silent)
keymap("n", "gn", ":bn<CR>", silent)
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", silent)
keymap("n", "gp", ":bp<CR>", silent)
keymap("n", "<S-q>", ":BufferClose<CR>", silent)

keymap("n", "<leader>q", "<cmd>lua require('utils').toggle_quicklist()<CR>", silent)
keymap("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
keymap("n", "ge", "<cmd>lua vim.diagnostic.goto_next()<CR>`", silent)
keymap("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)

vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })
vim.keymap.set('n', '<M-b>', '<cmd>Telescope lsp_references<cr>', { buffer = true })
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "WW", ":w!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>ga", ":Git add -- ", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit -m \"", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push -u origin HEAD<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>gd", ":Gdiffsplit<CR>", { noremap = false })
vim.keymap.set('n', 'H', '{', { buffer = true })
vim.keymap.set('n', 'J', '}', { buffer = true })
vim.keymap.set('n', 's', '', { buffer = true })
--vim.keymap.set('x', 's', '', { buffer = true })

--vim.g.blamer_enabled = 1
--vim.g.blamer_delay = 500

require('ufo-config')
require('spectre-config')
require("harpoon").setup()
require("telescope").load_extension('harpoon')
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-t>", function() ui.nav_next() end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end)
require("todo-comments").setup()

-- COMMENT
require("nvim_comment").setup({
	operator_mapping = "gc",
	line_mapping = "gc",
})


vim.g.gotests_bin = '/Users/caiofelix/go/bin/gotests'

vim.g.gotests_template_dir = ''

require('visual-multi')

vim.g.VM_leader                     = '<leader>'
vim.g.VM_maps['Find Under']         = 'gb'
vim.g.VM_maps['Find Subword Under'] = 'gb'

-- vim.keymap.set("v", "gb", '<cmd>execute "visual <Plug>(VM-Find-Under)"<CR>')
-- vim.keymap.set("v", "gb", '<cmd>execute "visual <Plug>(VM-Find-Subword-Under)"<CR>')
