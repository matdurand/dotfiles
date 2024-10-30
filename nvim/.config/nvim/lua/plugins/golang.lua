return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-extensions/nvim-ginkgo",
    },
    opts = {
      adapters = {
        ["nvim-ginkgo"] = {},
      },
    },
  }
}