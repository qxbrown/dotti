return {
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				session_lens = {
					buftypes_to_ignore = {},
					load_on_setup = true,
					theme_conf = { border = true },
					previewer = false,
				},
				vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
					noremap = true,
				}),
			})
		end,
	},
	{
		"barrett-ruth/live-server.nvim",
		config = function()
			vim.keymap.set("n", "<C-A-l>", ":LiveServerStart<CR>", {})
			vim.keymap.set("n", "<C-A-c>", ":LiveServerStop<CR>", {})
			require("live-server").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"NStefan002/speedtyper.nvim",
		cmd = "Speedtyper",
		opts = {
			language = "en",
			game_modes = {
				rain = {
					initial_speed = 0.5,
					throttle = -1,
				},
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true, -- enable treesitter
				ts_config = {
					lua = { "string" }, -- don't add pairs in lua string treesitter nodes
					javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
					java = false, -- don't check treesitter on java
				},
			})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
