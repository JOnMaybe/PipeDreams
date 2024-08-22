local args = {...}
-- Update script
-- Automatically downloads ComputerCraft programs to a computer

urls = {
    {"pipe.lua",         "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/pipe.lua"},
    {"superUpdate.lua",  "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/superUpdate.lua"}

}

if #args == 1 then
  table.insert(urls, #urls + 1, {"startup.lua", "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/pipe.lua"})
end

function download(name, url, pos)
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
    if pos ~= #urls and #args == 1 then
      file.write(data)
    else 
      print ("goofy")
      file.write("shell.run(\"pipe " + args[1] + "\")") --yikes
    end
    file.close()
  end
 
  print("Successfully downloaded " .. name .. "\n")
end

for key, value in ipairs(urls) do
    download(unpack(value), key)
end

term.clear()
term.setCursorPos(1, 1) 

