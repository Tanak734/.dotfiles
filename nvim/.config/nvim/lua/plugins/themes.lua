return {
  -- Plugin Kanagawa (inclui a variante Dragon)
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    opts = {
      theme = "dragon", -- Define explicitamente a variante Dragon
      background = { dark = "dragon", light = "lotus" },
    },
  },

  -- Outros temas que você já tinha (exemplo)
  { "catppuccin/nvim", name = "catppuccin" },

  -- Configura o LazyVim para usar o Kanagawa como padrão
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
