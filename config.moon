config = require "lapis.config"

config "production", ->
  port 80
  num_workers 2
  code_cache "on"
