lapis = require "lapis"
http = require "lapis.nginx.http"

class extends lapis.Application
  "/get/*": =>
    splat = @params.splat\gsub "https:/", "https://"
    @params.splat = nil

    request_string = "?"
    for key, value in pairs @params
      request_string ..= "#{key}=#{value}&"
    request_string = request_string\sub 1, -2

    body, status_code, headers = http.simple "#{splat}#{request_string}"

    return layout: false, status: status_code, body
    -- todo return with same headers?



              -- a post request, data table is form encoded and content-type is set to
              -- application/x-www-form-urlencoded
              --http.simple "http://leafo.net/", {
              --  name: "leafo"
              --}

              -- manual invocation of the above request
              --http.simple {
              --  url: "http://leafo.net"
              --  method: "POST"
              --  headers: {
              --    "content-type": "application/x-www-form-urlencoded"
              --  }
              --  body: {
              --    name: "leafo"
              --  }
              --}
