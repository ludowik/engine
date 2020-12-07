local socket_http = require 'socket.http'

class('http')

function http.request(url, success, fail, parameterTable)
    local result, code, headers = socket_http.request(url)

    local tempFile = image.getPath('data')
    local data = save(tempFile, result, 'wb')

    if headers['content-type'] and headers['content-type']:startWith('image') then
        data = image('data')
    end

    success(data, code, headers)
end
