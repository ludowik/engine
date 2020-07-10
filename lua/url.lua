function openURL(url, internal)
    assert(not internal)
    return print(os.execute("explorer.exe "..url))
end
