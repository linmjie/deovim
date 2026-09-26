-- Bootstrap lazy.nvim
vim.opt.termguicolors = false
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim

require("lazy").setup({
	spec = {
		-- import your plugins
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{
			"nvim-telescope/telescope.nvim",
			tag = "v0.1.9",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
			config = function()
				require("telescope").setup({
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown({}),
						},
					},
				})
				require("telescope").load_extension("ui-select")
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "main",
			lazy = false,
			config = function()
				require("nvim-treesitter").install({
					"rust",
					"c",
					"lua",
					"cpp",
					"python",
					"markdown",
					"markdown_inline",
				})
				vim.api.nvim_create_autocmd("FileType", {
					callback = function(args)
						pcall(vim.treesitter.start, args.buf)
					end,
				})
			end,
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		{ "nvim-tree/nvim-web-devicons", opts = {} },
		{
			"nvim-lualine/lualine.nvim",
			options = {
				icons_enabled = true,
				theme = "dracula",
			},
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				null_ls.setup({
					source = {
						null_ls.builtins.formatting.stylua,
					},
				})
			end,
		},

		--[[
    --OIL
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    ]]
		--

		--SNIPPETS
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		{
			"saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			dependencies = {
				{ "L3MON4D3/LuaSnip", version = "v2.*" },
				"rafamadriz/friendly-snippets",
			},

			-- use a release tag to download pre-built binaries
			version = "1.*",
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				keymap = {
					preset = "enter",
				},

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = {
					documentation = { auto_show = true },
				},

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				snippets = { preset = "luasnip" },
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
			opts_extend = { "sources.default" },
		},

		--DEBUG TOOLS
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				"rcarriga/nvim-dap-ui",
				dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			},
			config = function()
				local dap = require("dap")
				local dapui = require("dapui")

				require("dapui").setup()
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end

				dap.adapters.cppdbg = {
					id = "cppdbg",
					type = "executable",
					command = "/home/lin/.vscode/extensions/ms-vscode.cpptools-1.29.3-linux-x64/debugAdapters/bin/OpenDebugAD7",
				}

				dap.configurations.cpp = {
					{
						name = "Launch file",
						type = "cppdbg",
						request = "launch",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopAtEntry = true,
					},
					{
						name = "Attach to gdbserver :1234",
						type = "cppdbg",
						request = "launch",
						MIMode = "gdb",
						miDebuggerServerAddress = "localhost:1234",
						miDebuggerPath = "/usr/bin/gdb",
						cwd = "${workspaceFolder}",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
					},
				}
			end,
		},

		--MISC TOOLS
		{
			"norcalli/nvim-colorizer.lua",
		},
		{
			"Wansmer/treesj",
			keys = { "<space>ms", "<space>j", "<space>s" },
			dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
			config = function()
				require("treesj").setup({ --[[ your config ]]
				})
			end,
		},
		{
			"echasnovski/mini.surround",
			opts = {
				{
					-- Add custom surroundings to be used on top of builtin ones. For more
					-- information with examples, see `:h MiniSurround.config`.
					custom_surroundings = nil,

					-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
					highlight_duration = 500,

					-- Module mappings. Use `''` (empty string) to disable one.
					mappings = {
						add = "sa", -- Add surrounding in Normal and Visual modes
						delete = "sd", -- Delete surrounding
						find = "sf", -- Find surrounding (to the right)
						find_left = "sF", -- Find surrounding (to the left)
						highlight = "sh", -- Highlight surrounding
						replace = "sr", -- Replace surrounding

						suffix_last = "l", -- Suffix to search with "prev" method
						suffix_next = "n", -- Suffix to search with "next" method
					},

					-- Number of lines within which surrounding is searched
					n_lines = 20,

					-- Whether to respect selection type:
					-- - Place surroundings on separate lines in linewise mode.
					-- - Place surroundings on each line in blockwise mode.
					respect_selection_type = false,

					-- How to search for surrounding (first inside current line, then inside
					-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
					-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
					-- see `:h MiniSurround.config`.
					search_method = "cover",

					-- Whether to disable showing non-error feedback
					-- This also affects (purely informational) helper messages shown after
					-- idle time if user input is required.
					silent = false,
				},
			},
			{
				"vyfor/cord.nvim",
			},
			{
				"kevinhwang91/nvim-hlslens",
				config = function()
					require("hlslens").setup()
				end,
			},
			{
				"sheng-tse/jupynvim",
				build = function(plugin)
					local install = loadfile(plugin.dir .. "/lua/jupynvim/install.lua")()
					install.run(plugin)
				end,
				config = function()
					require("jupynvim").setup({
						log_level = "info",
						image_renderer = "placeholder", -- "placeholder", "kitty", or "chafa"
					})
				end,
			},
		},
	},

	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("catppuccin").setup()
require("lualine").setup()
vim.cmd.colorscheme("catppuccin")
