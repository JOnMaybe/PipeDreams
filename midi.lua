while true do
    local response, err = http.get("http://your.server.ip:5000/get_note")  -- Replace with your server's IP
    if response then
        local note = response.readAll()
        if note and note ~= "" then
            rednet.broadcast(note)
        end
    else
        print("HTTP GET request failed: " .. (err or "Unknown error"))
    end
    sleep(0.05)
end
