--[[
 My, mibac138 M[y]Net Server

]]

local tREQ = {[1] = {"githubapi"}, [2] = {"timeapi"}}
local dir = "/.mibac138/APIs"

ok, data = pcall(function() return shell.run("/.mibac138/Manager", "API", tREQ, dir, http) end)
