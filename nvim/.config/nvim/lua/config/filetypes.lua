-- lua/config/filetypes.lua
-- Filetype detection that Neovim doesn't get right on its own for DevOps work.

vim.filetype.add({
  extension = {
    tf = "terraform",
  },
  filename = {
    [".yamllint"] = "yaml",
  },
  pattern = {
    -- Helm templates: only when the file sits inside a chart (a Chart.yaml above it),
    -- so Ansible/CloudFormation "templates/" folders stay plain YAML.
    [".*/templates/.*%.ya?ml"] = function(path)
      return vim.fs.root(path, "Chart.yaml") and "helm" or "yaml"
    end,
    [".*/templates/.*%.tpl"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})
