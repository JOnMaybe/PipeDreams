local args = {...}
-- Update script
-- Automatically downloads ComputerCraft programs to a computer

urls = {
    {"pipe.lua",         "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/pipe.lua"},
    {"midi.lua",         "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/midi.lua"},
    {"superUpdate.lua",  "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/superUpdate.lua"}

}

if #args == 1 then
  local data = "shell.run(\"pipe " .. args[1] .. "\")"
  local name = "startup.lua"
  if fs.exists(name) then
    fs.delete(name)
    file = fs.open(name, "w")
    file.write(data)
    file.close()
  else
    file = fs.open(name, "w")
    file.write(data)
    file.close()
  end
  --table.insert(urls, #urls + 1, {"startup.lua", "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/pipe.lua"})
end

function download(name, url)
  print("Updating " .. name)
 
  request = http.get(url)
  data = request.readAll()
 
  if fs.exists(name) then
    fs.delete(name)
    file = fs.open(name, "w")
    file.write(data)
    file.close()
  else
    file = fs.open(name, "w")
    file.write(data)
    file.close()
  end
 
  print("Successfully downloaded " .. name .. "\n")
end
i = 1
for key, value in ipairs(urls) do
    download(unpack(value))
    i = i + 1
end

term.clear()
term.setCursorPos(1, 1) 

