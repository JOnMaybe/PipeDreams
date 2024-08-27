while true do
    local response = http.get("http://192.168.0.131:5000/get_note")  -- Replace with your server's IP
    if response then
        local note = response.readAll()
        if note and note ~= "" then
            rednet.broadcast(note)
        end
    end
    sleep(0.05)
end
