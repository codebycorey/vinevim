local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not ok then
  return
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

-- Hightlights symbols on hover
local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- Adds keymappings and other functionality to LSP on attach function
local on_attach = function(client, bufnr)
  local function keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  keymap('n', 'gd', '<Cmd>lua.lsp.buf.definition()<CR>', opts)

  lsp_highlight_document(client)
end

local capabilities = cmp_nvim_lsp.update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server.name == 'semneko_lua' then
    local sumneko_opts = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
    opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
  end
  server:setup(opts)
end)

