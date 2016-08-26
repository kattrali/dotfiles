function description()
  return "Append text to the current url and open it"
end

function run()
  windex = focused_window_index()
  webdex = focused_webview_index(windex)
  url = webview_uri(windex, webdex)
  if #arguments > 0 then
    load_uri(windex, webdex, url .. arguments[1])
  end
  return true
end
