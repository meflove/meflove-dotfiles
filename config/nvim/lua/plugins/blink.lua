return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = 'L3MON4D3/LuaSnip',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = 'super-tab' },

      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',

      windows = {
        autocomplete = {
          -- draw = "reversed",
          winblend = vim.o.pumblend,
        },
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental auto-brackets support
      accept = {
        auto_brackets = { enabled = true },
        expand_snippet = function(...)
          return require("luasnip").lsp_expand(...)
        end,
      },

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefining it
    opts_extend = { "sources.completion.enabled_providers" }
  },

  -- LSP servers and clients communicate what features they support through "capabilities".
  --  By default, Neovim support a subset of the LSP specification.
  --  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
  --  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
  --
  -- This can vary by config, but in general for nvim-lspconfig:

  -- {
  --   'neovim/nvim-lspconfig',
  --   dependencies = { 'saghen/blink.cmp' },
  --   config = function(_, opts)
  --     local lspconfig = require('lspconfig')
  --     for server, config in pairs(opts.servers or {}) do
  --       config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  --       lspconfig[server].setup(config)
  --     end
  --   end
  -- },
  -- add blink.compat
  { 'saghen/blink.compat' },

  {
    'saghen/blink.cmp',
    dependencies = {
      -- add source
      { "dmitmel/cmp-digraphs" },
    },
    sources = {
      completion = {
        -- remember to enable your providers here
        enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'digraphs' }
      },

      providers = {
        -- create provider
        digraphs = {
          name = 'digraphs', -- IMPORTANT: use the same name as you would for nvim-cmp
          module = 'blink.compat.source',

          -- all blink.cmp source config options work as normal:
          score_offset = -3,

          opts = {
            -- this table is passed directly to the proxied completion source
            -- as the `option` field in nvim-cmp's source config

            -- this is an option from cmp-digraphs
            cache_digraphs_on_start = true,
          }
        }
      }
    }
  },
}
