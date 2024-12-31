vim.opt.guifont = "Jetbrains Mono:h12"
vim.opt.hidden = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.wo.relativenumber = true
vim.opt.mouse = "a"
vim.opt.inccommand = "split"
vim.opt.colorcolumn = "80,120"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.scrolloff = 4

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.spell = true
vim.opt.spelllang = "en,pt_br"

--vim.opt.foldmethod = "indent"
--vim.opt.foldlevel = 1

vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menuone,noinsert,noselect"

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
  "nvim-lua/plenary.nvim",
  { "ahmedkhalf/project.nvim",   config = true,  name = "project_nvim" }, -- manage projects
  "LunarVim/bigfile.nvim",
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Visual
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        relative = "editor",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
  },
  "nvim-treesitter/nvim-treesitter",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_x = { "harpoon2", "encoding", "fileformat", "filetype" },
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },

  -- Notes
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "telescope",
      })
    end,
  },

  -- File Navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
      terms = {
        settings = {
          save_on_toggle = false,
          select_with_nil = false,
          sync_on_ui_close = false,
        },
      },
    },
  },
  {
    "Peeeaje/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left" } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down" } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up" } },
      { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
    },
    opts = {},
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        side = "right",
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = true,
    branch = "master",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 4000,
        ignore_whitespace = false,
      },
    },
  },

  --HTTP requests
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("rest-nvim").setup({
        jump_to_request = true,
      })
    end,
    version = "1.1",
  },

  -- lsp
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    -- config = function()
    -- 	local lspconfig = require("lspconfig")
    -- 	local configs = require("lspconfig.configs")
    --
    -- 	-- Configure it
    -- 	configs.blade = {
    -- 		default_config = {
    -- 			-- Path to the executable: laravel-dev-generators
    -- 			cmd = { "laravel-dev-tools", "lsp" },
    -- 			filetypes = { "blade", "php" },
    -- 			root_dir = function(fname)
    -- 				return lspconfig.util.find_git_ancestor(fname)
    -- 			end,
    -- 			settings = {},
    -- 		},
    -- 	}
    -- 	-- Set it up
    -- 	lspconfig.blade.setup({
    -- 		-- Capabilities is specific to my setup.
    -- 		capabilities = capabilities,
    -- 	})
    -- end,
  },
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  -- {
  -- 	"stevearc/conform.nvim",
  -- 	opts = {
  -- 		formatters_by_ft = {
  -- 			lua = { "stylua" },
  -- 			php = {
  -- 				pint = {
  -- 					tmpfile_format = "/tmp/.conform.$RANDOM.$FILENAME",
  -- 				},
  -- 				"php_cs_fixer",
  -- 				stop_after_first = true,
  -- 			},
  -- 			javascript = { "biome" },
  -- 			typescript = { "biome" },
  -- 			typescriptreact = { "biome" },
  -- 		},
  -- 		format_on_save = {
  -- 			-- These options will be passed to conform.format()
  -- 			timeout_ms = 10000,
  -- 			lsp_format = "fallback",
  -- 		},
  -- 	},
  -- },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local async_formatting = function(bufnr)
        bufnr = bufnr or vim.api.nvim_get_current_buf()

        vim.lsp.buf_request(
          bufnr,
          "textDocument/formatting",
          vim.lsp.util.make_formatting_params({}),
          function(err, res, ctx)
            if err then
              local err_msg = type(err) == "string" and err or err.message
              -- you can modify the log message / level (or ignore it completely)
              vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
              return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
              return
            end

            if res then
              local client = vim.lsp.get_client_by_id(ctx.client_id)
              vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
              vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("silent noautocmd update")
              end)
            end
          end
        )
      end
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.biome,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.pint.with({
            temp_dir = "/tmp",
            timeout = 10000,
          }),
          null_ls.builtins.diagnostics.credo,
          null_ls.builtins.formatting.mix,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                async_formatting(bufnr)
              end,
            })
          end
        end,
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  --
  -- autocomplete
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "saadparwaiz1/cmp_luasnip",
  "https://codeberg.org/FelipeLema/cmp-async-path",
  { "windwp/nvim-autopairs", config = true },

  -- snippets
  "rafamadriz/friendly-snippets",
  "L3MON4D3/LuaSnip",

  -- key bindings
  { "folke/which-key.nvim",  config = true },

  -- Debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "",
          },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        force_buffers = true,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = "",
        },
        layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.2,
              },
              {
                id = "breakpoints",
                size = 0.2,
              },
              {
                id = "stacks",
                size = 0.2,
              },
              {
                id = "watches",
                size = 0.2,
              },
              {
                id = "repl",
                size = 0.2,
              },
            },
            position = "right",
            size = 40,
          },
        },
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t",
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      })

      dap.adapters.php = {
        type = "executable",
        command = vim.fn.expand(vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter")),
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
        },
      }

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
    end,
  },
})

vim.cmd.colorscheme("catppuccin-latte")

vim.keymap.set("x", "<leader>x", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local harpoon = require("harpoon")

---@type HarpoonList
local term_list = harpoon:list("terms")

---@return string name of the created terminal
local function create_terminal()
  vim.cmd("terminal")
  local buf_id = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_name(buf_id)
end

---@param index number: The index of the terminal to select.
local function select_term(index)
  if index > term_list:length() then
    create_terminal()
    print("Creating terminal", index)
    -- just append the newly open terminal
    term_list:add()
  else
    -- find in list
    print("selecting terminal", index)
    term_list:select(index)
  end
end

-- Autocommand to remove closed terminal from the list
vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function(_)
    for _, term in ipairs(term_list.items) do
      local bufnr = vim.fn.bufnr(term.value)
      if bufnr == -1 then
        print("Removing:" .. term.value)
        term_list:remove(term)
      end
    end
  end,
})

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    ["<leader>"] = {
      "<cmd>Telescope find_files<cr>",
      "Find File",
    },
    d = {
      name = "+debugger",
      i = { "<cmd>DapNew<cr>", "[I]nit debug" },
      b = { "<cmd>DapToggleBreakpoint<cr>", "toggle [B]reakpointg" },
      c = { "<cmd>DapContinue<cr>", "[C]ontinue debug" },
      j = { "<cmd>DapStepInto<cr>", "Step Into" },
      k = { "<cmd>DapStepOut<cr>", "Step Out" },
      l = { "<cmd>DapStepOver<cr>", "Step Over" },
      t = { "<cmd>DapTerminate<cr>", "[T]erminate debug" },
      u = {
        name = "+ui",
        o = {
          function()
            require("dapui").open()
          end,
          "[O]pen debug ui",
        },
        c = {
          function()
            require("dapui").close()
          end,
          "[C]lose debug ui",
        },
      },
    },
    b = {
      name = "+buffer",
      a = { "<cmd>Telescope buffers<cr>", "List [A]ll" },
      k = { "<cmd>bdelete<cr>", "[K]ill" },
      c = {
        name = "+close",
        c = { "<cmd>bdelete<cr>", "Close [C]urrent" },
      },
      L = { "<cmd>Telescope buffers<cr>", "[L]ist all" },
    },
    f = {
      name = "+file",
      f = { "<cmd>Telescope find_files<cr>", "[F]ind File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open [R]ecent File" },
      n = { "<cmd>enew<cr>", "[N]ew File" },
    },
    o = {
      name = "+open",
      p = { "<cmd>NvimTreeToggle<cr>", "[P]roject sidebar" },
      t = {
        function()
          select_term(1)
        end,
        "[T]erminal",
      },
    },
    g = {
      name = "+git",
      g = { "<cmd>Neogit<cr>", "Open neogit" },
    },
    P = { "<cmd>Lazy<cr>", "Plugins" },
    p = {
      name = "+Projects",
      p = { "<cmd>Telescope projects<cr>", "Open [P]roject" },
      s = { "<cmd>Telescope live_grep<cr>", "[S]earch in project" },
      f = { "<cmd>Telescope find_files<cr>", "Find [F]ile" },
    },
    r = {
      name = "+Rest",
      r = { "<Plug>RestNvim", "[R]un request" },
      p = { "<Plug>RestNvimPreview", "[P]preview request" },
      l = { "<Plug>RestNvimLast", "run [L]ast request" },
    },
    s = {
      name = "+Search",
      p = { "<cmd>Telescope projects<cr>", "Open [P]roject" },
      f = { "<cmd>Telescope find_files<cr>", "Find [F]ile" },
      s = { "<cmd>Telescope live_grep<cr>", "[S]earch in project" },
      w = { "<cmd>Telescope grep_string<cr>", "Search [W]ord in Project" },
      r = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and [R]eplace" },
    },
    h = {
      name = "+Harpoon",
      a = {
        function()
          harpoon:list():add()
        end,
        "[A]dd file",
      },
      m = {
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        "Toggle [M]enu",
      },
      h = {
        function()
          harpoon:list():prev({ ui_nav_wrap = true })
        end,
        "Navigate to prev",
      },
      l = {
        function()
          harpoon:list():next({ ui_nav_wrap = true })
        end,
        "Navigate to next",
      },
      n = {
        name = "+Navigate",
        q = {
          function()
            harpoon:list():select(1)
          end,
          "Navigate to 1",
        },
        w = {
          function()
            harpoon:list():select(2)
          end,
          "Navigate to 2",
        },
        e = {
          function()
            harpoon:list():select(3)
          end,
          "Navigate to 3",
        },
        r = {
          function()
            harpoon:list():select(4)
          end,
          "Navigate to 4",
        },
        t = {
          function()
            harpoon:list():select(5)
          end,
          "Navigate to 5",
        },
        y = {
          function()
            harpoon:list():select(6)
          end,
          "Navigate to 6",
        },
        u = {
          function()
            harpoon:list():select(7)
          end,
          "Navigate to 7",
        },
        i = {
          function()
            harpoon:list():select(8)
          end,
          "Navigate to 8",
        },
        o = {
          function()
            harpoon:list():select(9)
          end,
          "Navigate to 9",
        },
        p = {
          function()
            harpoon:list():select(10)
          end,
          "Navigate to 10",
        },
      },
      s = { "<cmd>Telescope harpoon marks<cr>", "[S]how marks" },
      t = {
        name = "+Terminal",
        m = {
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list("terms"))
          end,
          "Toggle [M]enu",
        },
        q = {
          function()
            select_term(1)
          end,
          "Open Terminal 1",
        },
        w = {
          function()
            select_term(2)
          end,
          "Open Terminal 2",
        },
        e = {
          function()
            select_term(3)
          end,
          "Open Terminal 3",
        },
        r = {
          function()
            select_term(4)
          end,
          "Open Terminal 4",
        },
        t = {
          function()
            select_term(5)
          end,
          "Open Terminal 5",
        },
        y = {
          function()
            select_term(6)
          end,
          "Open Terminal 6",
        },
        u = {
          function()
            select_term(7)
          end,
          "Open Terminal 7",
        },
        i = {
          function()
            select_term(8)
          end,
          "Open Terminal 8",
        },
        o = {
          function()
            select_term(9)
          end,
          "Open Terminal 9",
        },
        p = {
          function()
            select_term(10)
          end,
          "Open Terminal 10",
        },
      },
    },
    l = {
      name = "+LSP",
      m = { "<cmd>Mason<cr>", "[M]anage LSP" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ctions" },
      r = { "<cmd>Telescope lsp_references<cr>", "Show [R]eferences" },
      i = { "<cmd>Telescope lsp_implementations<cr>", "Show [I]mplementation" },
      e = {
        function()
          vim.diagnostic.open_float()
        end,
        "Show [E]rror",
      },
      f = {
        function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(client)
              return client.name == "null-ls"
            end,
          })
        end,
        "[F]ormat code",
      },
      c = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[C]hange name" },
      h = {
        function()
          vim.lsp.buf.hover()
        end,
        "[H]over code",
      },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[S]ignature help" },
      d = { "<cmd>Telescope diagnostics<cr>", "Show [D]iagnostics" },
      p = { "<cmd>Telescope spell_suggest<cr>", "Show s[P]ell sugestions" },
    },
    v = {
      name = "+Visual",
      c = { "<cmd>Telescope colorscheme<cr>", "Select [C]olorscheme" },
      l = { "<cmd>set background=light<cr>", "Set [L]ight background" },
      d = { "<cmd>set background=dark<cr>", "Set [D]ark background" },
    },
    n = {
      name = "+Notes",
      n = {
        "+New note",
        n = {
          function()
            require("zk.commands").get("ZkNew")({ title = vim.fn.input("Título: ") })
          end,
          "[N]ew note",
        },
        z = {
          "+Zettelkasten",
          f = {
            function()
              require("zk.commands").get("ZkNew")({ dir = "fleeting", title = vim.fn.input("Título: ") })
            end,
            "New [F]leeting note",
          },
          r = {
            function()
              require("zk.commands").get("ZkNew")({ dir = "raw", title = vim.fn.input("Título: ") })
            end,
            "New [R]aw highlight",
          },
          l = {
            function()
              require("zk.commands").get("ZkNew")({
                dir = "literature",
                title = vim.fn.input("Título: "),
              })
            end,
            "New [L]iterature note",
          },
          m = {
            function()
              require("zk.commands").get("ZkNew")({ dir = "maybe", title = vim.fn.input("Título: ") })
            end,
            "New [M]aybe note",
          },
          p = {
            function()
              require("zk.commands").get("ZkNew")({ dir = "permanent", title = vim.fn.input("Título: ") })
            end,
            "New [P]ermanent note",
          },
        },
        j = {
          "+Journal",
          d = {
            function()
              require("zk.commands").get("ZkNew")({ dir = "journal/daily", date = "today" })
            end,
            "New [D]aily note",
          },
          m = {
            function()
              require("zk.commands").get("ZkNew")({ dir = "journal/monthly", date = "today" })
            end,
            "New [m]onthly note",
          },
        },
        s = {
          "+Study",
          w = {
            function()
              require("zk.commands").get("ZkNew")({ dir = "work", title = vim.fn.input("Título: ") })
            end,
            "New [W]ork note",
          },
          l = {
            function()
              require("zk.commands").get("ZkNew")({
                dir = "latim",
                extra = { tags = "#latim #gramatica" },
                title = vim.fn.input("Título: "),
              })
            end,
            "New [l]atim note",
          },
          j = {
            function()
              require("zk.commands").get("ZkNew")({
                dir = "jiu-jitsu",
                extra = { tags = "#jiu-jitsu#" },
                title = vim.fn.input("Título: "),
              })
            end,
            "New [J]iu-jitsu note",
          },
        },
      },
      s = { "<cmd>ZkNotes<cr>", "[S]earch note" },
      r = {
        name = "+repository",
        c = {
          function()
            vim.fn.system("zk save")
          end,
          "[C]ommit changes",
        },
        s = {
          function()
            vim.fn.system("zk ss")
          end,
          "[S]ave and [S]ync repository",
        },
        u = {
          function()
            vim.fn.system("zk sync")
          end,
          "[U]pdate repository",
        },
      },
    },
  },
})

require("telescope").load_extension("projects")
require("telescope").load_extension("harpoon")

local lsp = require("lsp-zero").preset({})
lsp.extend_lspconfig()

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false,
  })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "zk", "biome", "intelephense" },
  handlers = {
    lsp.default_setup,
  },
})

local cmp = require("cmp")
local cmp_format = lsp.cmp_format()
local cmp_action = lsp.cmp_action()
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  completion = {
    keyword_length = 1,
  },
  sources = {
    { name = "nvim_lsp",   keyword_length = 1 },
    { name = "luasnip",    keyword_length = 1 },
    { name = "buffer",     keyword_length = 1 },
    { name = "async_path", keyword_length = 3 },
  },
})

lsp.setup()

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = true,
  float = {
    source = true,
  },
})
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float()
  end,
})

vim.filetype.add({ extension = { p8 = "p8" } })

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "blade",
}
vim.treesitter.language.register("lua", "p8")
vim.env.ZK_NOTEBOOK_DIR = os.getenv("HOME") .. "/arquivos/zk"
vim.env.ZK_NOTEBOOK_DIR = os.getenv("HOME") .. "/arquivos/zk"
vim.treesitter.language.register("lua", "p8")
vim.env.ZK_NOTEBOOK_DIR = os.getenv("HOME") .. "/arquivos/zk"
vim.env.ZK_NOTEBOOK_DIR = os.getenv("HOME") .. "/arquivos/zk"
