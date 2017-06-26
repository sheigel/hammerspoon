-- Launch applications
local k = hs.hotkey.modal.new({}, "F16")

-- A global variable for the Hyper Mode
-- k = hs.htkey.modal.new({}, "F19")
pressedHyper = function()
	-- windowManagementId = hs.alert.show('Window Management mode', 'WindowAlert')
    k.triggered = false
    k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedHyper = function()
    -- hs.alert.closeSpecific(windowManagementId)

    k:exit()
    -- if not k.triggered then hs.eventtap.keyStroke({}, 'ESCAPE')
    -- end
end
local keyModifiers = {
    {''},
    {'shift'},
    {'ctrl'},
    {'alt'},
    {'cmd'},
    {'shift', 'alt'},
    {'shift', 'cmd'},
    {'shift', 'ctrl'},
    {'ctrl', 'alt'},
    {'ctrl', 'cmd'},
    {'alt', 'cmd'},
    {'ctrl', 'alt', 'cmd'},
    {'shift', 'alt', 'cmd'},
    {'shift', 'ctrl', 'cmd'},
    {'shift', 'ctrl', 'alt'},
    {'shift', 'ctrl', 'alt', 'cmd'}
}

for idx, modif in ipairs(keyModifiers) do
    hs.hotkey.bind(modif, 'F17', pressedHyper, releasedHyper)

end

local keyMapping = {}
keyMapping['h']= 'left'
keyMapping['j']= 'down'
keyMapping['k']= 'up'
keyMapping['l']= 'right'
keyMapping['0']= 'F12'
keyMapping['9']= 'F11'

local delay = 275

for key, value in pairs(keyMapping) do
    for idx, modif in ipairs(keyModifiers) do
        k:bind(modif, key, function() 
                hs.eventtap.keyStroke(modif, value, delay) 
            end, nil, function()
            hs.eventtap.keyStroke(modif, value, delay)
        end)
    end
end