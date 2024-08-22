local args = {...}
local modem = peripheral.find("modem")
 
local myNote = args[1]
 
modem.open(65535)
 
function mysplit(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
    end
    return t
end

while true do
   local id, msg = rednet.receive(nil, 5)
   if msg ~= nil and msg ~= "" then 
        local notesInMsg = mysplit(msg, ",")
            local playing = false
        for _,v in pairs(notesInMsg) do
            if v == myNote then
            playing = true
            break
            end
        end
        redstone.setOutput("top", playing);
        
    end
end
