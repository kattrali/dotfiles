function description()
  return "Copies the page URL into the command bar"
end

function run()
  windex = focused_window_index()
  webdex = focused_webview_index(windex)
  url = webview_uri(windex, webdex)
  set_command_field_text(windex, url)
end
