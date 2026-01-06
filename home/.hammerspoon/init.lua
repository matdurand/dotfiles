-- =========================================================================
--  HAMMERSPOON CONFIG: SLACK TO OBSIDIAN
-- =========================================================================

-- 1. GLOBAL CONFIGURATION
local vaultPath = "/Users/mathieu.durand/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main/"
local hyper = {"cmd", "alt", "ctrl", "shift"}
local targetApp = "Slack"

-- =========================================================================
--  HELPER FUNCTIONS
-- =========================================================================

-- Helper: Sanitize string for filenames (remove / : etc)
local function sanitizeFilename(str)
    if not str then return "Untitled" end
    -- Replace illegal chars with hyphen
    local clean = str:gsub("[/\\:*?\"<>|]", "-")
    -- Trim whitespace
    clean = clean:match("^%s*(.-)%s*$")
    -- Limit length to prevent filesystem errors
    if #clean > 50 then clean = string.sub(clean, 1, 50) end
    return clean
end

-- Helper: The Heavy Lifting (Get Text & Link safely)
local function getSlackContext()
    -- APP CHECK
    local focusedWindow = hs.window.focusedWindow()
    local activeApp = focusedWindow and focusedWindow:application():name()
    if activeApp ~= targetApp then
        hs.alert.show("⚠️ Command only works in Slack")
        return nil, nil
    end

    -- 1. RELEASE GUARD
    while next(hs.eventtap.checkKeyboardModifiers()) ~= nil do
        hs.timer.usleep(100000)
    end
    hs.timer.usleep(100000)

    -- 2. CAPTURE TEXT
    hs.pasteboard.clearContents()
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.usleep(300000)
    local selectedText = hs.pasteboard.getContents()

    -- 3. CAPTURE LINK (Widest Ancestor Method)
    hs.pasteboard.clearContents()
    local mousePos = hs.mouse.absolutePosition()
    local targetPos = {x = mousePos.x + 50, y = mousePos.y} -- Default fallback

    local elem = hs.axuielement.systemWideElement():elementAtPosition(mousePos)
    if elem then
        local current = elem
        local bestFrame = nil
        local maxWidth = 0
        local iterations = 0
        
        while current and iterations < 8 do
            local frame = current:attributeValue("AXFrame")
            if frame then
                if frame.w > maxWidth and frame.w < 3000 then 
                    maxWidth = frame.w
                    bestFrame = frame
                end
            end
            current = current:attributeValue("AXParent")
            iterations = iterations + 1
        end

        if bestFrame then
            -- Target Header Zone (Right Edge - 15px, Top Edge + 15px)
            targetPos = {x = bestFrame.x + bestFrame.w - 15, y = bestFrame.y + 15}
        end
    end

    -- EXECUTE CLICK
    hs.mouse.absolutePosition(targetPos)
    hs.timer.usleep(50000)
    hs.eventtap.rightClick(targetPos)
    hs.timer.usleep(600000) -- Wait for menu
    hs.eventtap.keyStroke({}, "l")
    hs.timer.usleep(300000)
    hs.mouse.absolutePosition(mousePos) -- Return mouse

    local link = hs.pasteboard.getContents()
    
    if not link then
        hs.alert.show("❌ Link Copy Failed")
        return nil, nil
    end

    -- 4. MODAL INPUT (If no text selected)
    local content = selectedText
    if not content then
        hs.focus()
        local button, input = hs.dialog.textPrompt("Slack Capture", "Enter text:", "", "Save", "Cancel")
        if focusedWindow then focusedWindow:focus() end
        if button == "Save" and input ~= "" then
            content = input
        else
            return nil, nil -- Cancelled
        end
    end

    return content, link
end

-- =========================================================================
--  SHORTCUT 1: CLIP TO OBSIDIAN (Hyper + C)
-- =========================================================================
hs.hotkey.bind(hyper, "C", function()
    local content, link = getSlackContext()
    if not content then return end

    local timestamp = os.date("%Y-%m-%d %H-%M-%S")
    local filename = "Slack/Slack - " .. timestamp .. ".md"
    local fullPath = vaultPath .. filename

    -- TEMPLATE: CLIPPING
    local fileContent = "---\n" ..
                        "categories: slack\n" ..
                        "---\n" ..
                        "# Slack Clipping\n\n" ..
                        content .. "\n\n" ..
                        link .. "\n"

    local file = io.open(fullPath, "w")
    if file then
        file:write(fileContent)
        file:close()
        hs.alert.show("✅ Clipped to Obsidian")
    else
        hs.alert.show("❌ Error: Check 'Slack' folder exists!")
    end
end)

-- =========================================================================
--  SHORTCUT 2: CREATE TODO (Hyper + O)
-- =========================================================================
hs.hotkey.bind(hyper, "O", function()
    local content, link = getSlackContext()
    if not content then return end

    -- Prepare Filenames & Dates
    local timestampFile = os.date("%Y-%m-%d %H-%M-%S")
    local dateScheduled = os.date("%Y-%m-%d")
    local dateISO = os.date("%Y-%m-%dT%H:%M:%S.000-05:00") -- Adjust timezone offset if needed
    
    -- Sanitize content for filename (TaskNotes/Tasks/...)
    local taskFilenameStr = sanitizeFilename(content)

    -- FILE 1: The Task (TaskNotes/Tasks/content.md)
    local taskFileRelative = "TaskNotes/Tasks/" .. taskFilenameStr .. ".md"
    local taskFullPath = vaultPath .. taskFileRelative
    
    local taskContent = "---\n" ..
                        "status: open\n" ..
                        "priority: normal\n" ..
                        "scheduled: " .. dateScheduled .. "\n" ..
                        "dateCreated: " .. dateISO .. "\n" ..
                        "dateModified: " .. dateISO .. "\n" ..
                        "tags:\n" ..
                        "  - task\n" ..
                        "---\n" ..
                        link .. "\n"

    -- Write File
    local f1 = io.open(taskFullPath, "w")
    if f1 then
        f1:write(taskContent)
        f1:close()
        hs.alert.show("✅ Created TODO")
    else
        hs.alert.show("❌ Error writing TODO Task File")
    end
end)