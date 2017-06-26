local mod = {}
local snippets = {
    {
        ["text"] ='eigel.si@gmail.com'
    },
    {
        ["text"] ='silviu.eigel@thinslices.com'
    },
    
}


local log = hs.logger.new('anycomplete ===', 'info')
-- Anycomplete
function mod.anycomplete()
    local GOOGLE_ENDPOINT = 'https://suggestqueries.google.com/complete/search?client=firefox&q=%s'
    local current = hs.application.frontmostApplication()
    local tab = nil
    local copy = nil
    local choices = {}

    local chooser = hs.chooser.new(function(choosen)
        if copy then copy:delete() end
        if tab then tab:delete() end
        current:activate()
        hs.eventtap.keyStrokes(choosen.text)
    end)

    -- Removes all items in list
    function reset()
        chooser:choices({})
    end

    tab = hs.hotkey.bind('', 'tab', function()
        local id = chooser:selectedRow()
        local item = choices[id]
        -- If no row is selected, but tab was pressed
        if not item then return end
        chooser:query(item.text)
        reset()
        updateChooser()
    end)

    copy = hs.hotkey.bind('cmd', 'c', function()
        local id = chooser:selectedRow()
        local item = choices[id]
        if item then
            chooser:hide()
            hs.pasteboard.setContents(item.text)
            hs.alert.show("Copied to clipboard", 1)
        else
            hs.alert.show("No search result to copy", 1)
        end
    end)
    function printTable(table)
       return hs.inspect.inspect(table)
    end
    function updateChooser()
        local string = chooser:query()
        local query = hs.http.encodeForQuery(string)
        local remainingSnippets = hs.fnutils.filter(snippets, function(snip)
            return string.match(snip["text"], query)
        end)
        -- Reset list when no query is given
        if string:len() == 0 then return reset() end

        hs.http.asyncGet(string.format(GOOGLE_ENDPOINT, query), nil, function(status, data)
            if not data then return end

            local ok, results = pcall(function() return hs.json.decode(data) end)
            if not ok then return end

            choices = hs.fnutils.concat(remainingSnippets,
                hs.fnutils.imap(results[2], function(result)
                    return {
                        ["text"] = result,
                    }
                end)
            )
            chooser:choices(choices)
        end)
    end

    chooser:queryChangedCallback(updateChooser)

    chooser:searchSubText(false)

    chooser:show()
end

function mod.registerDefaultBindings(mods, key)
    mods = mods or {"ctrl", "alt", "shift", "cmd"}
    key = key or "space"
    hs.hotkey.bind(mods, key, mod.anycomplete)
end
mod.registerDefaultBindings()
return mod