-- lua/debug.lua

local dap = require("dap")
local dapui = require("dapui")

---------------------------------------------------------------------
-- 1. DAP UI LAYOUT (all windows in the bottom area)
---------------------------------------------------------------------
dapui.setup({
  layouts = {
    {
      position = "right",
      size = 0.30, -- bottom strip takes 30% of screen height
      elements = {
        { id = "watches",      size = 0.20 }, -- locals / variables
        { id = "stacks",      size = 0.20 }, -- threads + call stack
        { id = "breakpoints", size = 0.20 }, -- breakpoints list
        { id = "repl",        size = 0.20 }, -- GDB / DAP console
        { id = "scopes",        size = 0.20 }, -- GDB / DAP console
      },
    },
  },
})

---------------------------------------------------------------------
-- 2. AUTO OPEN/CLOSE UI ON DEBUG SESSION
---------------------------------------------------------------------
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

---------------------------------------------------------------------
-- 3. SIGNS + HIGHLIGHTING
--    - red ball: verified breakpoint
--    - gray ball: not loaded / rejected breakpoint
--    - highlight current line when stopped
---------------------------------------------------------------------

-- Verified breakpoint (loaded)
vim.fn.sign_define("DapBreakpoint", {
  text   = "●",
  texthl = "DapBreakpoint",
  numhl  = "",
})

-- Gray ball for unverified / not-yet-loaded breakpoints
vim.fn.sign_define("DapBreakpointRejected", {
  text   = "●",
  texthl = "DapBreakpointRejected",
  numhl  = "",
})

vim.fn.sign_define("DapBreakpointUnverified", {
  text   = "●",
  texthl = "DapBreakpointRejected",
  numhl  = "",
})

-- Arrow + full-line highlight when execution is stopped
vim.fn.sign_define("DapStopped", {
  text   = "▶",
  texthl = "DapStopped",
  numhl  = "",
  linehl = "DapStoppedLine",
})

-- Now define the highlight groups using **cterm** only.
-- cterm values chosen to match your palette:
--   red     = 9
--   grey    = 249
--   green   = 10
--   bg-ish  = 60 (nice contrast with your dark background)

vim.cmd([[
  highlight DapBreakpoint         ctermfg=9   ctermbg=NONE cterm=NONE
  highlight DapBreakpointRejected ctermfg=249 ctermbg=NONE cterm=NONE
  highlight DapStopped            ctermfg=10  ctermbg=NONE cterm=NONE
  highlight DapStoppedLine        ctermfg=NONE ctermbg=239 cterm=NONE
]])


---------------------------------------------------------------------
-- 4. CORTEX-DEBUG SETUP (AS YOU REQUESTED)
---------------------------------------------------------------------
require("dap-cortex-debug").setup({
  debug          = false,
  extension_path = nil,  -- auto-detect if possible
  lib_extension  = nil,
  node_path      = "node",
})

-- Your requested line: keep C++ config same as C
dap.configurations.cpp = dap.configurations.c

