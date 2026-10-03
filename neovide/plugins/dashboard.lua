-- ~/.config/nvim/lua/plugins/dashboard.lua (Windows 11 + PowerShell 7 build)
--
-- Recreation of the "SHANTO" dashboard mockup, built on LazyVim's default
-- snacks.nvim dashboard. Panels are swapped vs. the original mockup: the
-- menu/banner side is now LEFT, the art side is now RIGHT, per request.
-- This version targets Windows specifically -- no cross-platform branching.
--
-- REQUIRES:
--   * LazyVim on Windows 11 (this extends the real folke/snacks.nvim spec)
--   * A Nerd Font is NOT required for the menu anymore (emoji icons now),
--     but LazyVim itself still wants one for its own UI elsewhere.
--
-- The SHANTO banner is now a plain Lua string baked directly into this file
-- (SHANTO_TOP / SHANTO_BODY below) -- no external .ans file, no shell
-- command, no PowerShell, no caching. This replaces the earlier approach
-- that shelled out to read a file, which hit real encoding corruption on
-- Windows. Trade-off: this uses two flat colors (top row / body) via
-- Neovim's own highlight groups instead of a smooth per-pixel gradient,
-- but it can no longer break from an external process, a codepage
-- mismatch, or a stale cache -- it's just a string, the same mechanism the
-- badge box and kaomoji already use successfully.
--
-- SETUP: see the chat message this came with for the full walkthrough.
--   1. Save this file as lua\plugins\dashboard.lua
--   2. That's it for the banner -- nothing else to copy for it now.
--
-- NOTE ON THE "S" ART: you asked for the floral "S" image to be converted
-- below the art panel, but that image didn't actually reach me (checked --
-- only the original mockup made it through). PLACEHOLDER_S_ART below is a
-- simple emoji stand-in so the layout isn't empty in the meantime. Re-send
-- the image and I'll convert it and embed it the same self-contained way
-- the banner is now done -- no separate file needed.

-- Exact figlet "ANSI Shadow" output for SHANTO, split into a top row
-- (colored separately to echo the mockup's two-tone look) and the body.
-- Generated once via the real font, not retyped by hand.
local SHANTO_TOP =
  "███████╗██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██████╗ "
local SHANTO_BODY = table.concat({
  "██╔════╝██║  ██║██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗",
  "███████╗███████║███████║██╔██╗ ██║   ██║   ██║   ██║",
  "╚════██║██╔══██║██╔══██║██║╚██╗██║   ██║   ██║   ██║",
  "███████║██║  ██║██║  ██║██║ ╚████║   ██║   ╚██████╔╝",
  "╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ",
}, "\n")

-- Temporary stand-in for the floral "S" illustration until the real image
-- comes through -- NOT a conversion of your actual picture. Built on a
-- 5x7 block grid (each blank cell is two spaces to match an emoji's
-- double-width in a terminal, so the S shape actually lines up).
local PLACEHOLDER_S_ART = table.concat({
  "  🌸🌸🌸🌸",
  "🌼        ",
  "🌼        ",
  "  🌷🌷🌷🌷",
  "        🌺",
  "        🌺",
  "🌼🌼🌼🌼  ",
}, "\n")

-- Decorative placeholder for the left pane. This is NOT a reproduction of
-- the illustration in the mockup (a hand-drawn girl-and-bunny piece) -- see
-- the setup notes for why that specific art can't be reproduced as text/
-- config. This just evokes the same sparkly, pastel vibe on its own.
---@type string
local ART_PLACEHOLDER = table.concat({
  "",
  "",
  "        ✨    🌟         💫  ⭐",
  "    💫                  🌸",
  "          ⭐                    ✨",
  "    🌼",
  "               🌟",
  "         ✨",
  "                      🌸",
  "    ⭐              ✨    🌟",
  "          💫  🌼      ⭐",
  "",
}, "\n")

local SHANTO_BADGE = table.concat({
  "┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐",
  "╎      SHANTO      ╎",
  "└╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘",
}, "\n")

-- Best-effort transcription of the small kaomoji in the mockup. At that
-- size in the source image this is a judgment call, not a certainty.
local KAOMOJI = table.concat({
  "      ^",
  "   (\\_/)",
  "  ( ˘ᴗ˘ )",
  "  /  🎀  \\",
  '   o_(")(")',
}, "\n")

-- Dynamic footer: real date/time/plugin-count/nvim-version, not hardcoded
-- demo values, laid out in the same 5-column stat-bar style as the mockup.
local function stats_footer()
  local ok, lazy_stats = pcall(function()
    return require("lazy").stats()
  end)
  local count = ok and lazy_stats.count or 0
  local ms = ok and (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100) or 0

  local nv = vim.version()
  local nvim_str = string.format("v%d.%d.%d", nv.major, nv.minor, nv.patch)
  -- LuaJIT's own version string includes a long build timestamp
  -- (e.g. "LuaJIT 2.1.1725663913"); show just "2.1" like the mockup does.
  local lj_str = "LuaJIT"
  if jit and jit.version then
    local v = jit.version:match("(%d+%.%d+)")
    if v then
      lj_str = "LuaJIT " .. v
    end
  end

  local cols = {
    { "  DATE", { os.date("%b %d, %Y"), os.date("%A") } },
    { "  TIME", { os.date("%I:%M:%S %p"), "" } },
    { "  LOADED", { count .. " plugins", "in " .. ms .. " ms" } },
    { " NEOVIM", { nvim_str, lj_str } },
    { "  LAZYVIM", { "Let's code!", "" } },
  }

  local w = 13
  local function pad(s)
    s = s or ""
    local dw = vim.fn.strwidth(s)
    if dw > w then
      s = vim.fn.strcharpart(s, 0, w)
      dw = vim.fn.strwidth(s)
    end
    if dw >= w then
      return s
    end
    return s .. string.rep(" ", w - dw)
  end

  local function row(getter)
    local parts = {}
    for _, c in ipairs(cols) do
      table.insert(parts, pad(getter(c)))
    end
    return "│ " .. table.concat(parts) .. " │"
  end

  local inner = w * #cols
  local top = "╭" .. string.rep("─", inner + 2) .. "╮"
  local bot = "╰" .. string.rep("─", inner + 2) .. "╯"

  local lines = {
    top,
    row(function(c)
      return c[1]
    end),
    row(function(c)
      return c[2][1]
    end),
    row(function(c)
      return c[2][2]
    end),
    bot,
  }

  return {
    text = table.concat(lines, "\n"),
    hl = "DashLavender",
    align = "center",
    padding = 1,
  }
end

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      width = 70,
      pane_gap = 4,
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = "🔍 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "📝 ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "🕰️ ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "🗂️ ", key = "p", desc = "Projects", section = "projects" },
          { icon = "💬 ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = "⚙️ ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "💾 ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "📦 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = "🎁 ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "👋 ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        {
          pane = 1,
          { text = SHANTO_TOP, hl = "DashPink", align = "center" },
          { text = SHANTO_BODY, hl = "DashLavender", align = "center", padding = 0 },
          { text = '"oh my" 🩷', hl = "DashPink", align = "center" },
          { text = SHANTO_BADGE, hl = "DashPink", align = "center", padding = 1 },
          { text = KAOMOJI, hl = "DashLavender", align = "center", padding = 1 },
          { section = "keys", gap = 1, padding = 1 },
          stats_footer,
          {
            text = "Code is like humor. When you have to explain it, it's bad.",
            hl = "DashDim",
            align = "center",
            padding = 1,
          },
          { text = "Happy Coding! 💕", hl = "DashPink", align = "center" },
        },
        {
          pane = 2,
          { text = ART_PLACEHOLDER, hl = "DashPink", align = "center", padding = 1 },
          -- Real "S" art slot -- once you resend the image, this becomes a
          -- plain { text = SHANTO_S_ART, hl = ..., align = "center" } entry,
          -- the same self-contained way the banner above is now done.
          { text = PLACEHOLDER_S_ART, hl = "DashLavender", align = "center", padding = 1 },
        },
      },
    },
  },
  config = function(_, opts)
    local function set_hl()
      vim.api.nvim_set_hl(0, "DashPink", { fg = "#ff9ec4" })
      vim.api.nvim_set_hl(0, "DashLavender", { fg = "#c4bff5" })
      vim.api.nvim_set_hl(0, "DashDim", { fg = "#8886b3" })
    end
    set_hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
    require("snacks").setup(opts)
  end,
}
