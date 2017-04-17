lapis = require "lapis"
http = require "lapis.nginx.http"

class extends lapis.Application
  "/get/*": =>
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

    body, status_code, headers = http.simple "#{splat}#{request_string}"

    return layout: false, status: status_code, body
    -- todo return with same headers?

  "/test/*": =>
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

    return layout: false, "#{splat}#{request_string}"
