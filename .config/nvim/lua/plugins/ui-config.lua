return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },
          lualine_b = { "filename", "branch" },
          lualine_c = { "fileformat" },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    vim.api.nvim_set_keymap("n", "<C-w>", ":bd<CR>", { noremap = true, silent = true }),
    vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }),
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {
          always_show_bufferline = false,
          show_buffer_close_icons = false,
          show_tab_indicators = true,
          diagnostics = "nvim_lsp",
        },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
        command_palette = true,
      },
    },
    vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" }),
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  --[[
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        display = {
          render_limit = 16, -- How many LSP messages to show at once
          done_ttl = 3, -- How long a message should persist after completion
          done_icon = "✔",
          progress_icon = { pattern = "meter", period = 1 },
        },
      },

      notification = {
        poll_rate = 60, -- FPS
        view = {
          stack_upwards = true,
          icon_separator = " ",
          group_separator = "---",
        },

        window = {
          normal_hl = "Comment", -- Base highlight group in the notification window
          winblend = 0,     -- Background color opacity in the notification window
          border = "double", -- Border around the notification window
          x_padding = 1,
          y_padding = 0,
          relative = "editor",
        },
      },
    },
    config = function()
      require("fidget").setup({
        	{
						progress = {
							poll_rate = 0, -- How and when to poll for progress messages
							suppress_on_insert = false, -- Suppress new messages while in insert mode
							ignore_done_already = false, -- Ignore new tasks that are already complete
							ignore_empty_message = false, -- Ignore new tasks that don't contain a message
							clear_on_detach = function(client_id)
								local client = vim.lsp.get_client_by_id(client_id)
								return client and client.name or nil
							end,
							notification_group = function(msg)
								return msg.lsp_client.name
							end,
							ignore = {}, -- List of LSP servers to ignore

							-- Options related to how LSP progress messages are displayed as notifications
							display = {
								render_limit = 16, -- How many LSP messages to show at once
								done_ttl = 3, -- How long a message should persist after completion
								done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
								done_style = "Constant", -- Highlight group for completed LSP tasks
								progress_ttl = math.huge, -- How long a message should persist when in progress
								-- Icon shown when LSP progress tasks are in progress
								progress_icon = { pattern = "dots", period = 1 },
								-- Highlight group for in-progress LSP tasks
								progress_style = "WarningMsg",
								group_style = "Title", -- Highlight group for group name (LSP server name)
								icon_style = "Question", -- Highlight group for group icons
								priority = 30, -- Ordering priority for LSP notification group
								skip_history = true, -- Whether progress notifications should be omitted from history
								-- How to format a progress message
								format_message = require("fidget.progress.display").default_format_message,
								-- How to format a progress annotation
								format_annote = function(msg)
									return msg.title
								end,
								-- How to format a progress notification group's name
								format_group_name = function(group)
									return tostring(group)
								end,
								overrides = { -- Override options from the default notification config
									rust_analyzer = { name = "rust-analyzer" },
								},
							},

							-- Options related to Neovim's built-in LSP client
							lsp = {
								progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
								log_handler = false, -- Log `$/progress` handler invocations (for debugging)
							},
						},

						-- Options related to notification subsystem
						notification = {
							poll_rate = 10, -- How frequently to update and render notifications
							filter = vim.log.levels.INFO, -- Minimum notifications level
							history_size = 128, -- Number of removed messages to retain in history
							override_vim_notify = false, -- Automatically override vim.notify() with Fidget
							-- How to configure notification groups when instantiated
							configs = { default = require("fidget.notification").default_config },
							-- Conditionally redirect notifications to another backend
							redirect = function(msg, level, opts)
								if opts and opts.on_open then
									return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
								end
							end,

							-- Options related to how notifications are rendered as text
							view = {
								stack_upwards = true, -- Display notification items from bottom to top
								icon_separator = " ", -- Separator between group name and icon
								group_separator = "---", -- Separator between notification groups
								-- Highlight group used for group separator
								group_separator_hl = "Comment",
								-- How to render notification messages
								render_message = function(msg, cnt)
									return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
								end,
							},

							-- Options related to the notification window and buffer
							window = {
								normal_hl = "Comment", -- Base highlight group in the notification window
								winblend = 100, -- Background color opacity in the notification window
								border = "none", -- Border around the notification window
								zindex = 45, -- Stacking priority of the notification window
								max_width = 0, -- Maximum width of the notification window
								max_height = 0, -- Maximum height of the notification window
								x_padding = 1, -- Padding from right edge of window boundary
								y_padding = 0, -- Padding from bottom edge of window boundary
								align = "bottom", -- How to align the notification window
								relative = "editor", -- What the notification window position is relative to
							},
						},

						-- Options related to integrating with other plugins
						integration = {
							["nvim-tree"] = {
								enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
							},
							["xcodebuild-nvim"] = {
								enable = true, -- Integrate with wojciech-kulik/xcodebuild.nvim (if installed)
							},
						},

						-- Options related to logging
						logger = {
							level = vim.log.levels.WARN, -- Minimum logging level
							max_size = 10000, -- Maximum log file size, in KB
							float_precision = 0.01, -- Limit the number of decimals displayed for floats
							-- Where Fidget writes its logs to
							path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
						},
					},
      })
    end,
  },
  ]]

  --[[
  {
    "VonHeikemen/fine-cmdline.nvim",
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      vim.api.nvim_set_keymap("n", "<CR>", "<cmd>FineCmdline<CR>", { noremap = true })
      require("fine-cmdline").setup({
        	cmdline = {
					enable_keymaps = true,
					smart_history = true,
					prompt = ": ",
				},
				popup = {
					position = {
						row = "10%",
						col = "50%",
					},
					size = {
						width = "60%",
					},
					border = {
						style = "rounded",
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				hooks = {
					before_mount = function(input)
						-- code
					end,
					after_mount = function(input)
						-- code
					end,
					set_keymaps = function(imap, feedkeys)
						-- code
					end,
				},
      })
    end,
  },
  ]]
  --[[
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        relative = "editor",
        title_pos = "center",
      },
    },
    config = function()
      require("dressing").setup({
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,

          -- Default prompt string
          default_prompt = "Input",

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Can be 'left', 'right', or 'center'
          title_pos = "left",

          -- When true, <Esc> will close the modal
          insert_only = true,

          -- When true, input will start in insert mode.
          start_in_insert = true,

          -- These are passed to nvim_open_win
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "cursor",

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 40,
          width = nil,
          -- min_width and max_width can be a list of mixed types.
          -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },

          buf_options = {},
          win_options = {
            winhighlight = 'NormalFloat:DiagnosticError',
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = "precedes:…,extends:…",
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,
          },

          -- Set to `false` to disable
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,

          -- see :help dressing_get_config
          get_config = nil,
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,

          -- Priority list of preferred vim.select implementations
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Options for telescope selector
          -- These are passed into the telescope picker directly. Can be used like:
          -- telescope = require('telescope.themes').get_ivy({...})
          telescope = nil,

          -- Options for fzf selector
          fzf = {
            window = {
              width = 0.5,
              height = 0.4,
            },
          },

          -- Options for fzf-lua
          fzf_lua = {
            -- winopts = {
            --   height = 0.5,
            --   width = 0.5,
            -- },
          },

          -- Options for nui Menu
          nui = {
            position = "50%",
            size = nil,
            relative = "editor",
            border = {
              style = "rounded",
            },
            buf_options = {
              swapfile = false,
              filetype = "DressingSelect",
            },
            win_options = {
              winblend = 0,
            },
            max_width = 80,
            max_height = 40,
            min_width = 40,
            min_height = 10,
          },

          -- Options for built-in selector
          builtin = {
            -- Display numbers for options and set up keymaps
            show_numbers = true,
            -- These are passed to nvim_open_win
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "editor",

            buf_options = {},
            win_options = {
              cursorline = true,
              cursorlineopt = "both",
            },

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- the min_ and max_ options can be a list of mixed types.
            -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },

            -- Set to `false` to disable
            mappings = {
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },

            override = function(conf)
              -- This is the config that will be passed to nvim_open_win.
              -- Change values here to customize the layout
              return conf
            end,
          },

          -- Used to override format_item. See :help dressing-format
          format_item_override = {},

          -- see :help dressing_get_config
          get_config = nil,
        },
      })
    end,
  },
  ]]
}
