local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.flake8.with({
        diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
        end,
        extra_args = {"--max-line-length","88"}
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
  },
})

