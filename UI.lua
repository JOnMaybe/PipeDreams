--ChatGPT wrote most of this, not my own work
-- Set the background to blue
term.setBackgroundColor(colors.blue)
term.clear()
rednet.open("back")
-- Get screen dimensions
local screenWidth, screenHeight = term.getSize()

-- Calculate key widths and heights based on screen size
local whiteKeyWidth = math.floor(screenWidth / 7)  -- 7 white keys per octave
local blackKeyWidth = math.floor(whiteKeyWidth * 0.6)
local keyHeight = math.floor(screenHeight / 4)     -- 4 octaves
local blackKeyHeight = math.floor(keyHeight * 0.6)

-- Define the white and black keys for an octave, starting with C
local whiteKeys = {
    {label = "C", xOffset = 0},  {label = "D", xOffset = 1},
    {label = "E", xOffset = 2},  {label = "F", xOffset = 3},
    {label = "G", xOffset = 4},  {label = "A", xOffset = 5}, {label = "B", xOffset = 6}
}

local blackKeys = {
    {label = "C#", xOffset = 0.5}, {label = "D#", xOffset = 1.5},
    {label = "F#", xOffset = 3.5}, {label = "G#", xOffset = 4.5}, {label = "A#", xOffset = 5.5}
}

-- Function to draw an octave
local function drawOctave(startY)
    -- Draw white keys
    for _, key in ipairs(whiteKeys) do
        local keyX = math.floor(key.xOffset * whiteKeyWidth) + 1
        -- Draw key body
        term.setBackgroundColor(colors.lightGray)
        for i = 0, keyHeight - 1 do
            term.setCursorPos(keyX, startY + i)
            term.write(string.rep(" ", whiteKeyWidth))  -- adjust width
        end
    end

    -- Draw black keys
    for _, key in ipairs(blackKeys) do
        local keyX = math.floor(key.xOffset * whiteKeyWidth) + math.floor(whiteKeyWidth * 0.7)
        -- Draw key body
        term.setBackgroundColor(colors.gray)
        for i = 0, blackKeyHeight - 1 do
            term.setCursorPos(keyX, startY + i)
            term.write(string.rep(" ", blackKeyWidth))  -- adjust width
        end
    end
end

-- Draw four octaves, scaled to screen size
for octave = 1, 4 do
    local startY = (octave - 1) * keyHeight + 1
    drawOctave(startY)
end

-- Handle mouse input
while true do
    local event, button, x, y = os.pullEvent("mouse_click")
    local msg = ""

    -- Detect key press for all four octaves
    local blackKeyPressed = false
    for octave = 1, 4 do
        local startY = (octave - 1) * keyHeight + 1
        
        -- Check black keys first
        for _, key in ipairs(blackKeys) do
            local keyX = math.floor(key.xOffset * whiteKeyWidth) + math.floor(whiteKeyWidth * 0.7)
            if x >= keyX and x < keyX + blackKeyWidth and y >= startY and y < startY + blackKeyHeight then
                if key.label == "A#" then
                    octave = octave - 1
                end
                msg = msg .. key.label .. octave+1 .. ","
                blackKeyPressed = true
                break
            end
        end
        
        -- If a black key was pressed, skip checking the white keys
        if blackKeyPressed then 
        rednet.broadcast(msg)
            break end 

        -- Check white keys
        for _, key in ipairs(whiteKeys) do
            local keyX = math.floor(key.xOffset * whiteKeyWidth) + 1
            if x >= keyX and x < keyX + whiteKeyWidth and y >= startY and y < startY + keyHeight then
                if key.label == "A" or key.label == "B" then
                    octave = octave - 1
                end
                msg = msg .. key.label .. octave+1 .. ","
            end
        end
    end
    rednet.broadcast(msg)

end
