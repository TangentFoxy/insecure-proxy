lapis = require "lapis"
http = require "lapis.nginx.http"

parse_url = =>
  local splat
  if @params.splat\find "https://"
    splat = @params.splat
  else
    splat = @params.splat\gsub "https:/", "https://"
  @params.splat = nil

  request_string = "?"
  for key, value in pairs @params
    request_string ..= "#{key}=#{value}&"
  request_string = request_string\sub 1, -2

  return "#{splat}#{request_string}"

class extends lapis.Application
  "/get/*": =>
    url = parse_url(@)
    body, status_code, headers = http.simple url

    -- IDEA forward headers in return?
    return layout: false, status: status_code, body

  "/test/*": =>
    return layout: false, parse_url(@)
