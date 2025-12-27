return
-- Lazy.nvim (recommended)
{
  "wolfwfr/vimatrix.nvim",
  opts = {

    auto_activation = {
      screensaver = {
        setup_deferral = 1,
        timeout = 0,
        ignore_focus = false,
        block_on_term = true,
        block_on_cmd_line = true,
      },
      on_filetype = {},
    },
    -- configuration options go here
    ---- Based on the first scene with Neo and Cypher.
    {
      droplet = {
        max_size_offset = 5,
        timings = {
          max_fps = 15,
          fps_variance = 1,
          glitch_fps_divider = 8,
          max_timeout = 200,
          local_glitch_frame_sharing = false,
          global_glitch_frame_sharing = true,
        },
        random = {
          body_to_tail = 50,
          head_to_glitch = 5,
          head_to_tail = 50,
          kill_head = 150,
          new_head = 30,
        },
      },
      colourscheme = "matrix",
    },
  },
}
