local function launchPreferredApp(primary, fallback)
  -- Try to find the app (by name or bundle ID)
  local appPath = hs.application.pathForBundleID(primary.bundleID)

  if appPath then
    hs.application.launchOrFocusByBundleID(primary.bundleID)
  else 
      if fallback then
        hs.alert.show(primary.name .. " not found, launching " .. fallback.name)
        hs.application.launchOrFocus(fallback.name)
    end
  end
end

-- Example: Try Alacritty, fallback to Terminal
hs.hotkey.bind({"alt"}, "T", function()
  launchPreferredApp(
    { name = "Alacritty", bundleID = "org.alacritty" },
    { name = "Terminal", bundleID = "com.apple.Terminal" }
  )
end)

hs.hotkey.bind({"alt"}, "B", function()
  launchPreferredApp(
    { name = "Brave", bundleID = "com.brave.Browser" },
    { name = "Chrome", bundleID = "com.google.Chrome" }
  )
end)

hs.hotkey.bind({"alt"}, "L", function()
  launchPreferredApp(
    { name = "ChatGPT", bundleID = "com.openai.chat" }
  )
end)

hs.hotkey.bind({"alt"}, "M", function()
  launchPreferredApp(
    { name = "Spotify", bundleID = "com.spotify.client" }
  )
end)

