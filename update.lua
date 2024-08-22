-- Update script
-- Automatically downloads ComputerCraft programs to a computer

urls = {
    {"Pipe",         "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/pipe.lua"},
    {"Update",       "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/update.lua"},
    {"SuperUpdate",  "https://raw.githubusercontent.com/JOnMaybe/PipeDreams/main/update.lua"}

}

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

for key, value in ipairs(urls) do
    download(unpack(value))
end

term.clear()
term.setCursorPos(0)
