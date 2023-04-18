-- local socket = package.loadlib([[C:\Users\10381830\Downloads\Newfolder\socket\core.dll]], 'luaopen_core')
-- package.cpath = package.cpath .. ";C:\\Users\\10381830\\Downloads\\Newfolder\\socket\\core.dll"
-- local socket = require("socket")
package.path="D:\\SteamLibrary\\steamapps\\common\\MonsterHunterRise\\reframework\\autorun\\socket"
local socket=dofile("D:\\SteamLibrary\\steamapps\\common\\MonsterHunterRise\\reframework\\autorun\\socket\\socket.lua")
local server = assert(socket.bind("*", 8080))
local client = server:accept()
client:settimeout(10)
print(server:getsockname())
print(client:getpeername())
log_to_file("Server started successfully..")

local function log_to_file( message)
    local file = io.open("log", "a")
    file:write(message .. "\n")
    file:close()
end

re.on_frame(function()
	local message = "response\n"
	print("Sending" )
	local succ, err = client:send(message)
end)

-- while true do



