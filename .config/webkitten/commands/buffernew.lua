function description()
  return "Opens a new buffer with a URL or configured start page"
end

function run()
  local windex = focused_window_index()
  if #arguments > 0 then
    local target = arguments[1]
    if target == "dev" then
      return open_with_config(windex, arguments[2], [[
      [general]
      private-browsing = false
      allow-plugins = false
      allow-javascript = true
      ]])
    elseif target == "tv" then
      return open_with_config(windex, arguments[2], [[
      [general]
      private-browsing = false
      allow-plugins = true
      allow-javascript = true
      ]])
    end
  end
  return open_with_defaults(windex, lookup_string(config_file_path, "window.start-page"))
end

function open_with_defaults(windex, target)
  if windex ~= NOT_FOUND then
    open_webview(windex, target)
  else
    open_window(target)
  end
  return true
end

function open_with_config(windex, target, config)
  if target == nil then
    target = lookup_string(config_file_path, "window.start-page")
  end
  if windex ~= NOT_FOUND then
    open_custom_webview(windex, target, config)
  else
    open_custom_window(target, config)
  end
  return true
end
