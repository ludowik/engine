function splitFilePath(fpath)
	-- Returns the Path, Filename, and Extension as 3 values
	if lfs.attributes(fpath, 'mode') == 'directory' then
		local strPath = fpath:gsub("[\\/]$", "")
		return strPath.."\\", "", ""
	end
    
	fpath = fpath.."."
	return fpath:match("^(.-)([^\\/]-%.([^\\/%.]-))%.?$")
end
