return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			vim.g.neotree_quit_on_open = 1 -- Close NeoTree after opening a file
			vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle right<CR>", {})

			require("neo-tree").setup({
				window = {
					mappings = {
						["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					},
				},
			})
		end,
	},
	{
		"3rd/image.nvim",
		config = function()
			-- default config
require("image").setup({
	backend = "kitty",
	integrations = {
	  markdown = {
		enabled = true,
		clear_in_insert_mode = false,
		download_remote_images = true,
		only_render_image_at_cursor = false,
		filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
	  },
	  neorg = {
		enabled = true,
		clear_in_insert_mode = false,
		download_remote_images = true,
		only_render_image_at_cursor = false,
		filetypes = { "norg" },
	  },
	},
	max_width = nil,
	max_height = nil,
	max_width_window_percentage = nil,
	max_height_window_percentage = 50,
	window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
	tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
  })
		end
	},
}

