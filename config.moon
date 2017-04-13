config = require "lapis.config"

config "development", ->
  port 16343
  num_workers 2
  code_cache "on"
