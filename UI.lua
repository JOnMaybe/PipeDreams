-- Set the background to blue
term.setBackgroundColor(colors.blue)
term.clear()

-- Get screen dimensions
local screenWidth, screenHeight = term.getSize()

-- Calculate key widths and heights based on screen size
local whiteKeyWidth = math.floor(screenWidth / 7)  -- 7 white keys per octave
local blackKeyWidth = math.floor(whiteKeyWidth * 0.6)
local keyHeight = math.floor(screenHeight / 4)     -- 4 octaves

-- Define the white and black keys for an octave, starting with C
local whiteKeys = {
    {label = "C", xOffset = 0},  {label = "D", xOffset = 1},
    {label = "E", xOffset = 2},  {label = "F", xOffset = 3},
    {label = "G", xOffset = 4},  {label = "A", xOffset = 5}, {label = "B", xOffset = 6}
}

local blackKeys = {
    {label = "C#", xOffset = 0.75}, {label = "D#", xOffset = 1.75},
    {label = "F#", xOffset = 3.75}, {label = "G#", xOffset = 4.75}, {label = "A#", xOffset = 5.75}
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
        local keyX = math.floor(key.xOffset * whiteKeyWidth) + math.floor((whiteKeyWidth - blackKeyWidth) / 2)
        -- Draw key body
        term.setBackgroundColor(colors.gray)
        for i = 0, math.floor(keyHeight * 0.6) - 1 do
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

    -- Detect key press for all four octaves
    for octave = 1, 4 do
        local startY = (octave - 1) * keyHeight + 1
        -- Check white keys
        for _, key in ipairs(whiteKeys) do
            local keyX = math.floor(key.xOffset * whiteKeyWidth) + 1
            if x >= keyX and x < keyX + whiteKeyWidth and y >= startY and y < startY + keyHeight then
                print("Played note: " .. key.label .. " in octave " .. octave)
            end
        end

        -- Check black keys
        for _, key in ipairs(blackKeys) do
            local keyX = math.floor(key.xOffset * whiteKeyWidth) + math.floor((whiteKeyWidth - blackKeyWidth) / 2)
            if x >= keyX and x < keyX + blackKeyWidth and y >= startY and y < startY + math.floor(keyHeight * 0.6) then
                print("Played note: " .. key.label .. " in octave " .. octave)
            end
        end
    end
end
