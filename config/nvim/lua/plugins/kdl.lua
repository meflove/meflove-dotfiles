return {
  {
    "neovim/nvim-lspconfig",
    ft = "kdl",
    opts = function(_, opts)
      -- Регистрируем сервер вручную
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.kdl_lsp then
        configs.kdl_lsp = {
          default_config = {
            cmd = { "kdl-lsp" },
            filetypes = { "kdl" },
            root_dir = lspconfig.util.find_git_ancestor,
            settings = {},
          },
        }
      end

      -- Подключаем LSP
      lspconfig.kdl_lsp.setup({
        capabilities = opts.capabilities,
        on_attach = opts.on_attach,
      })
    end,
  },
}
