local M = {}
local map = vim.keymap.set
local utils = require "utils"

-- local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

M.on_init = nvlsp.on_init
M.capabilities = nvlsp.capabilities

M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions { reuse_win = true }
  end, opts "Goto Definition")

  map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts "References")
  map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts "Implementations")
  map("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts "Type Definitions")

  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<leader>cA", utils.lsp.action.source, opts "Source Action")

  map("n", "<leader>q", vim.diagnostic.setloclist, opts "Diagnostic loclist")
end

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(_, args.buf)
    end,
  })

  vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
end

return M
