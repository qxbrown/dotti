return {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          local config = require("nvim-treesitter.configs")
          config.setup({
            ensure_installed = { "c", "lua", "query", "bash", "cpp", "css", "go", "html", "java", "javascript", "json", "yaml", "xml", "toml", "rust", "python", "markdown" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
      })
  end
}
