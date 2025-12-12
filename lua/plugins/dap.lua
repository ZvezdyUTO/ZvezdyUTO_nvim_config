--[[ return { ]]
--[[ 	"mfussenegger/nvim-dap", ]]
--[[ 	dependencies = { ]]
--[[ 		"rcarriga/nvim-dap-ui", ]]
--[[ 		"nvim-neotest/nvim-nio", ]]
--[[ 	}, ]]
--[[ 	config = function() ]]
--[[ 		local dap = require("dap") ]]
--[[ 		local dapui = require("dapui") ]]
--[[]]
--[[ 		dapui.setup() ]]
--[[]]
--[[ 		-- 自动打开 dap-ui ]]
--[[ 		dap.listeners.after.event_initialized["dapui_config"] = function() ]]
--[[ 			dapui.open() ]]
--[[ 		end ]]
--[[]]
--[[ 		dap.listeners.before.event_terminated["dapui_config"] = function() ]]
--[[ 			dapui.close() ]]
--[[ 		end ]]
--[[]]
--[[ 		dap.listeners.before.event_exited["dapui_config"] = function() ]]
--[[ 			dapui.close() ]]
--[[ 		end ]]
--[[]]
--[[ 		-- C++ / Rust: codelldb ]]
--[[ 		dap.adapters.codelldb = { ]]
--[[ 			type = "server", ]]
--[[ 			port = "${port}", ]]
--[[ 			executable = { ]]
--[[ 				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb", ]]
--[[ 				args = { "--port", "${port}" }, ]]
--[[ 			}, ]]
--[[ 		} ]]
--[[]]
--[[ 		dap.configurations.cpp = { ]]
--[[ 			{ ]]
--[[ 				name = "Launch", ]]
--[[ 				type = "codelldb", ]]
--[[ 				request = "launch", ]]
--[[ 				program = function() ]]
--[[ 					return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file") ]]
--[[ 				end, ]]
--[[ 				cwd = "${workspaceFolder}", ]]
--[[ 				stopOnEntry = false, ]]
--[[ 			}, ]]
--[[ 		} ]]
--[[]]
--[[ 		dap.configurations.c = dap.configurations.cpp ]]
--[[ 		dap.configurations.rust = dap.configurations.cpp ]]
--[[ 	end, ]]
--[[ } ]]
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		---------------------------------------------------------
		-- DAP UI
		---------------------------------------------------------
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		---------------------------------------------------------
		-- C / C++ / Rust : codelldb
		---------------------------------------------------------
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		---------------------------------------------------------
		-- Python : debugpy
		---------------------------------------------------------
		local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

		if vim.fn.filereadable(debugpy) == 1 then
			dap.adapters.python = {
				type = "executable",
				command = debugpy,
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = debugpy,
				},
			}
		end

		---------------------------------------------------------
		-- Go : delve (dlv)
		---------------------------------------------------------
		local dlv = vim.fn.expand("$HOME/go/bin/dlv")

		if vim.fn.filereadable(dlv) == 1 then
			dap.adapters.go = function(callback)
				vim.loop.spawn(dlv, {
					args = { "dap", "-l", "127.0.0.1:38697" },
				}, function(code)
					print("Delve exited with code:", code)
				end)

				vim.defer_fn(function()
					callback({
						type = "server",
						host = "127.0.0.1",
						port = 38697,
					})
				end, 300)
			end

			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "go",
					name = "Debug – Test",
					request = "launch",
					mode = "test",
					program = "./",
				},
			}
		end
	end,
}
