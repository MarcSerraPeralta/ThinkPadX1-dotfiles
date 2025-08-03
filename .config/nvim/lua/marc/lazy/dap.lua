return {
    "mfussenegger/nvim-dap",
    dependencies = {
  	    "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_python = require("dap-python")

        require("dapui").setup({})
        require("nvim-dap-virtual-text").setup({
            commented = true, -- show virtual text alongside comment
        })

        dap_python.setup("~/virtual_environments/debugpy/bin/python")

        -- automatically open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        local opts = { noremap = true, silent = true }

        -- toggle breakpoint
        vim.keymap.set("n", "<F4>", function()
            dap.toggle_breakpoint()
        end, opts)

        -- continue / Start
        vim.keymap.set("n", "<F6>", function()
            dap.continue()
        end, opts)

        -- step Over
        vim.keymap.set("n", "<F7>", function()
            dap.step_over()
        end, opts)

        -- step Into
        vim.keymap.set("n", "<F8>", function()
            dap.step_into()
        end, opts)

        -- step Out
        vim.keymap.set("n", "<F9>", function()
            dap.step_out()
        end, opts)
			
        -- keymap to terminate debugging
	    vim.keymap.set("n", "<F1>", function()
	        require("dap").terminate()
            dapui.toggle()
        end, opts)

    end,
}
