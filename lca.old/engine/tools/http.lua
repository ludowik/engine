local socket_http = require('socket.http')

class('http')

function http.request(url, success, fail, parameterTable)
    local data, c, h = socket_http.request(url)
    
    local file = fs.newFileData(data, 'data')
    
    success(file, c, h)
end
