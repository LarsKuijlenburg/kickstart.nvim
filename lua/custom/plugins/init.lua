-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	"mfussenegger/nvim-lint",
	event = {
	    "BufReadPre",
	    "BufNewFile",
	},
	config = function()
	  local lint = require("lint")

	  lint.linters_by_ft = {
	    javascript = { "eslint_d" },
	    typescript = { "eslint_d" },
	    javascriptreact = { "eslint_d" },
	    typescriptreact = { "eslint_d" },
	    svelte = { "eslint_d" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {
		group = lint_augroup,
		callback = function()
		  lint.try_lint()
		end
		})

	
	vim.keymap.set("n", "<leader>ll", function()
		lint.try_lint()
		end, { desc: "Trigger linting for current file" })
	end
}
