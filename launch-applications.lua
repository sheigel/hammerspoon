-- Launch applications

-- local modalKey = hs.hotkey.modal.new({}, "f19")
local k = hs.hotkey.modal.new({}, "F18")

-- A global variable for the Hyper Mode
-- k = hs.htkey.modal.new({}, "F19")
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F19', pressedF18, releasedF18)

-- function modalKey:entered()
	-- applicationLauncherId = hs.alert.show('Application Launcher', 'WindowAlert')
-- end
-- modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {
    A = 'Atom',
    C = 'Google Chrome Canary',
    D = 'Dash',
    E = 'evernote',
    F = 'finder',
    G = 'Gogland 1.0 eap',
    I = 'itunes',
    M = 'Messages',
    N = 'Notes',
    R = 'Rider',
    S = 'Safari',
    V = 'Visual Studio Code - Insiders',
    W = 'WebStorm',
    X = 'iterm',
    Y = 'Skype',
    Z = 'Franz'
}

for key, app in pairs(appShortCuts) do

    k:bind('', key, 'Launching '..app, function()
        k:exit()
        hs.application.launchOrFocus(app)
        k.triggered = true
    end)

end
--
-- modalKey:bind('', 'escape', function() modalKey:exit() end)
-- function modalKey:exited()
--     hs.alert.closeSpecific(applicationLauncherId)
-- end
