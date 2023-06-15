local opts = {
  cmd = {"vscode-json-languageserver", "--stdio"},
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true }
    }
  }
}

return opts
