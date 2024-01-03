return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    opts = {
      url_encode_path = true,
      use_absolute_path = true,
      prompt_for_file_name = false,
      drag_and_drop = {
        copy_images = true,
        download_images = true,
      },
    },
    keys = {
      -- suggested keymap
      { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
}
