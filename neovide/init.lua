-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd.cd("D:/code/Neovide")
-- vim.cmd.colorscheme("embark")
vim.cmd.colorscheme("catppuccin")
vim.opt.clipboard = "unnamedplus"
vim.opt.list = false
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
if vim.g.neovide then
  -- vim.o.guifont = "Terminess Nerd Font:h15" -- text below applies for VimScript
  -- vim.o.guifont = "JetBrainsMono Nerd Font:h12" -- text below applies for VimScript

  -- vim.o.guifont = "CaskaydiaCove Nerd Font:h12" -- text below applies for VimScript
  -- vim.o.guifont = "Monaspace Krypton NF"
  vim.o.guifont = "FiraCode Nerd Font Propo" -- text below applies for VimScript
  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.5

  -- Normal mode (Blue block)
  vim.api.nvim_set_hl(0, "CursorNormal", {
    fg = "#1e1e2e",
    bg = "#ff0571",
  })
  vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle Neovide Fullscreen" })
  -- Insert mode (Green line)
  vim.api.nvim_set_hl(0, "CursorInsert", {
    fg = "#1e1e2e",
    bg = "#a6e3a1",
  })

  vim.opt.guicursor = table.concat({
    "n-v-c:block-CursorNormal",
    "i-ci:ver30-CursorInsert",
  }, ",")

  vim.g.neovide_title_background_color =
    string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg)

  vim.g.neovide_title_text_color = "pink"
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  vim.g.neovide_pixel_geometry = "RGBH"
  vim.g.neovide_pixel_geometry = "RGBH"

  vim.g.neovide_corner_preference = "do_not_round"
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_floating_corner_radius = 0.0

  -- vim.g.neovide_opacity = 0.8
  -- vim.g.neovide_normal_opacity = 0.8
  vim.g.neovide_show_border = true
  vim.g.neovide_position_animation_length = 0.15
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_progress_bar_enabled = true
  vim.g.neovide_progress_bar_height = 5.0
  vim.g.neovide_progress_bar_animation_speed = 200.0
  vim.g.neovide_progress_bar_hide_delay = 0.2
  vim.g.neovide_message_area_drag_selection = true
  vim.g.neovide_underline_stroke_scale = 1.0
  vim.g.neovide_theme = "auto"
  vim.g.experimental_layer_grouping = false
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_fullscreen = false
  vim.g.neovide_highlight_matching_pair = true
  vim.g.neovide_input_ime = true
  local function set_ime(args)
    if args.event:match("Enter$") then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime,
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime,
  })
  vim.g.neovide_cursor_animation_length = 0.150
  vim.g.neovide_cursor_short_animation_length = 0.04
  vim.g.neovide_cursor_trail_size = 1.0
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125
  vim.g.nepovide_cursor_smooth_blink = true
  vim.g.neovide_has_mouse_grid_detection = true
end
