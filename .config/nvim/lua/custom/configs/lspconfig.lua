local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local root_pattern = require("plugins.configs.lspconfig").root_pattern

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers =
	{ "html", "cssls", "tsserver", "clangd", "rust_analyzer", "gopls", "jedi_language_server", "tailwindcss" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = root_pattern,
	})
end

lspconfig.omnisharp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/opt/omnisharp/OmniSharp", "--languageserver", "--hostPID", tostring(pid) },
})

-- vim.diagnostic.config {
--   virtual_text = {
--     prefix = "",
--   },
--   signs = false,
--   underline = true,
--   update_in_insert = false,
-- }
