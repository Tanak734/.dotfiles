return {
  {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "RunCode", "RunFile", "RunProject", "CRFiletype" },
    keys = {
      { "<leader>rr", ":RunCode<CR>", desc = "Run Code (Context)" },
      { "<leader>rf", ":RunFile<CR>", desc = "Run Current File" },
      { "<leader>rt", ":RunFile tab<CR>", desc = "Run File in New Tab" },
    },
    opts = {
      -- Escolha onde a saída aparece: "float", "tab", "vertical" ou "horizontal"
      mode = "term",
      focus = true,
      startinsert = true,
      filetype = {
        -- Linguagens que você pediu e mais algumas essenciais
        ruby = "ruby",
        python = "python3 -u",
        go = "go run",
        lua = "lua",
        sh = "bash",
        php = "php",
        perl = "perl",

        -- Compilação e Execução (C/C++)
        c = {
          "cd $dir &&",
          "gcc $fileName -o $fileNameWithoutExt &&",
          "$dir/$fileNameWithoutExt",
        },
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o $fileNameWithoutExt &&",
          "$dir/$fileNameWithoutExt",
        },

        -- Web / JS Runtimes
        javascript = "node",
        typescript = "ts-node", -- Requer o pacote ts-node instalado globalmente

        -- Rust (usando cargo se houver, ou rustc)
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
      },
    },
  },
}
