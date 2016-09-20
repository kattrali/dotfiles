function description()
  return "Update window title based on buffer content"
end

function on_focus()
  update_title(window_index, webview_index)
end

function on_fail_uri()
  update_title(window_index, webview_index)
end

function on_request_uri()
  set_window_title(window_index, default_title(window_index) .. "Loading...")
end

function on_load_uri()
  update_title(window_index, webview_index)
end

function update_title(window_index, webview_index)
  title = webview_title(window_index, webview_index)
  set_window_title(window_index, default_title(window_index) .. title)
end

function default_title(window_index)
  index = focused_webview_index(window_index)
  count = webview_count(window_index) - 1
  return "[" .. index .. "/" .. count .. "] "
end
