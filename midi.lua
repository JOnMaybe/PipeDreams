--chatgpt wrote this, not my own work
local server_url = "192.168.0.131:8080"

local playing_notes = {}

while true do
    local response = http.get(server_url)
    if response then
        local note_action = response.readAll()
        response.close()
        if note_action then
            local note, action = string.match(note_action, "([^:]+):([^:]+)")
            if action == "on" then
                table.insert(playing_notes, note)
            elseif action == "off" then
                for i, v in ipairs(playing_notes) do
                    if v == note then
                        table.remove(playing_notes, i)
                        break
                    end
                end
            end

            local broadcast_message = table.concat(playing_notes, " ")
            rednet.broadcast(broadcast_message)
        end
    end
    sleep(0.05)
end

