local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

local utils = require("null-ls.utils")

null_ls.setup {
  root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
  diagnostics_format = "#{m} (#{c}) [#{s}]",
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_command [[augroup Format]]
      vim.api.nvim_command [[autocmd! * <buffer>]]
      vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
      vim.api.nvim_command [[augroup END]]
    end
  end,
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.completion.spell,            -- You still need to execute `:set spell`
    null_ls.builtins.diagnostics.eslint,          -- Add eslint to js projects
    -- null_ls.builtins.diagnostics.phpcs.with({     -- Change how the php linting will work
    --   prefer_local = "vendor/bin",
    -- }),
    null_ls.builtins.formatting.stylua,           -- You need to install stylua first: `brew install stylua`
    null_ls.builtins.formatting.phpcbf.with({     -- Use the local installation first
      prefer_local = "vendor/bin",
    }),
  }
}
