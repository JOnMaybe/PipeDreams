while true do
    local response, err = http.get("http://192.168.0.131:5000/get_note")  -- Replace with your server's IP
    if response then
        local note = response.readAll()
        if note and note ~= "@" then
            -- Remove surrounding quotes if present
            note = note:gsub('^"(.*)"$', '%1')
            rednet.broadcast(note)
        end
        if note == "@" then
            rednet.broadcast("")
        end

    else
        print("HTTP GET request failed: " .. (err or "Unknown error"))
    end
    sleep(0.05)
end
