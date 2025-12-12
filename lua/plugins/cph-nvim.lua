return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("competitest").setup({
			testcases_use_single_file = true,
			testcases_directory = "./testcases",
			save_current_file = true,

			compile_command = {
				cpp = {
					exec = "g++",
					args = {
						"-std=gnu++20",
						"-o",
						"$(ABSDIR)/testcases/$(FNOEXT)",
						"$(FABSPATH)",
					},
				},
			},

			run_command = { cpp = { exec = "$(ABSDIR)/testcases/$(FNOEXT)" } },
			runner_ui = { interface = "popup" },
		})
	end,
}
