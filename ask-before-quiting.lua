-- local displaying = false
-- hs.hotkey.bind({ 'cmd' }, 'q', function()
--     local shouldKill   = true
--     local app = hs.application.frontmostApplication()
--     local appName = app:name()
 
--     local appleScriptText = string.gsub([[
--           tell application "{APP_NAME}" to set response to button returned of (display dialog "Are you sure you want to quit?" with icon 1 buttons {"Cancel", "Quit"})
--         ]], '{(.-)}', { APP_NAME = appName})
--         print(appleScriptText)
--     local _, result = hs.applescript.applescript(appleScriptText)
    
--     shouldKill = result == 'Quit'

--       if shouldKill then
--         app:kill()
--       else
--         local frontmostWindow = hs.window.frontmostWindow()
--         if frontmostWindow then frontmostWindow:focus() end
--       end
--     end)
  










--   function ext.app.askBeforeQuitting(appName, enabled, count)
--   count = count or 1

--   if not enabled and ext.cache.bindings[appName] then
--     ext.cache.bindings[appName]:disable()
--     return
--   end

--   if ext.cache.bindings[appName] then
--     ext.cache.bindings[appName]:enable()
--   else
--     ext.cache.bindings[appName] = hs.hotkey.bind({ 'cmd' }, 'q', function()
--       local windowsCount = ext.app.allWindowsCount(appName)
--       local shouldKill   = true

--       if windowsCount > count then
--         local _, result = hs.applescript.applescript(string.gsub([[
--           tell application "{APP_NAME}" to set response to button returned of (display dialog "There are multiple windows opened: {NUM_WINDOWS}\nAre you sure you want to quit?" with icon 1 buttons {"Cancel", "Quit"})
--         ]], '{(.-)}', { APP_NAME = appName, NUM_WINDOWS = windowsCount }))

--         shouldKill = result == 'Quit'
--       end

--       if shouldKill then
--         hs.appfinder.appFromName(appName):kill()
--       else
--         local frontmostWindow = hs.window.frontmostWindow()
--         if frontmostWindow then frontmostWindow:focus() end
--       end
--     end)
--   end
-- end