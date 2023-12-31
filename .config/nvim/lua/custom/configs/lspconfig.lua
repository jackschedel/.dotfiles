local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local root_pattern = require("plugins.configs.lspconfig").root_pattern
capabilities.offsetEncoding = "utf-8"

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers =
	{ "html", "cssls", "tsserver", "gopls", "jedi_language_server", "tailwindcss", "intelephense", "gdscript" }

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
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
	},
	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
	root_dir = function()
		return require("lspconfig/util").root_pattern(
			"*.sln",
			"*.csproj",
			"omnisharp.json",
			"*.godot",
			"function.json",
			".git"
		)(vim.fn.expand("%:p:h")) or vim.fn.expand("%:p:h")
	end,
})

lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.signatureHelpProvider = false
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
})
