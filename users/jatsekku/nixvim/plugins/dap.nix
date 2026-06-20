{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    dap = {
      enable = true;

      signs = {
        dapBreakpoint = {
          text = "●";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "⊜";
          texthl = "DapBreakpointCondition";
        };
        dapLogPoint = {
          text = "◆";
          texthl = "DapLogPoint";
        };
      };

      luaConfig.post = ''
        local dap = require("dap")
        local dapui = require("dapui")

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
      '';

      adapters = {
        executables = {
          gdb = {
            command = "${pkgs.gdb}/bin/gdb";
            args = [
              "--interpreter=dap"
              "--eval-command"
              "set print pretty on"
            ];
          };
          lldb = {
            command = "${pkgs.lldb_19}/bin/lldb-dap";
          };
        };
      };

      configurations = {
        c = [
          {
            name = "Launch";
            type = "lldb";
            request = "launch";
            program.__raw = # lua
              ''
                function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end
              '';
            cwd = "\${workspaceFolder}";
            stopAtEntry = true;
          }
        ];

      };
    };

    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap-lldb.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>db";
      action = ":lua require('dap').toggle_breakpoint()<CR>";
      mode = "n";
      options = {
        silent = true;
        noremap = true;
        desc = "Toggle breakpoint (DAP)";
      };
    }
    {
      key = "<leader>dc";
      action = ":lua require('dap').continue()<CR>";
      mode = "n";
      options = {
        silent = true;
        noremap = true;
        desc = "Continue execution (DAP)";
      };
    }
    {
      key = "<leader>di";
      action = ":lua require('dap').step_into()<CR>";
      mode = "n";
      options = {
        silent = true;
        noremap = true;
        desc = "Step into (DAP)";
      };
    }
    {
      key = "<leader>do";
      action = ":lua require('dap').step_over()<CR>";
      mode = "n";
      options = {
        silent = true;
        noremap = true;
        desc = "Step over (DAP)";
      };
    }
    {
      key = "<leader>du";
      action = ":lua require('dap').step_out()<CR>";
      mode = "n";
      options = {
        silent = true;
        noremap = true;
        desc = "Step out (DAP)";
      };
    }
    {
      key = "<leader>dq";
      action.__raw = ''
        function()
            require('dap').terminate()
            require('dapui').close()
        end
      '';
      mode = "n";
      options = {
        silent = true;
        noremap = true;
        desc = "Terminate session (DAP)";
      };
    }
  ];
}
