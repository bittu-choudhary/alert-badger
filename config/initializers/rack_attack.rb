Rack::Attack.throttle("Requests by IP", limit: 20, period: 60.seconds) do |req|
    req.ip
end