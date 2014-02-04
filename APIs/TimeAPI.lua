--[[
 My, mibac138 small Time API, inspired by surferpup's "Real World Time API".
]]

local Version = 1.0
local format = "2:1 4 3 5"
local website = "http://www.timeapi.org/"
local TZ = "utc/" -- Time Zone
local websiteParams = "now?format={[%22sec%22]=%25S,%20[%22time%22]=%22%25H:%25M%22,%20[%22day%22]=%25d,%20[%22month%22]=%22%25b%22,%20[%22year%22]=%25Y}"
local timeout = -1
local http = false

if not http then error("TimeAPI: HTTP API Not Enabled! TimeAPI Disabled!", 0) else http = true end

--[[ Helper Functions ]]--

local function getWebsite(_website)
 if not http then return false, "HTTP API Not Enabled!" end
 
 website = _website or website
 ok, data = pcall(function(website) return http.get(website).readAll() end)
 
 return ok, data
end

local function initTimer(_timeout)
 timeout = _timeout or timeout
 
 if timeout > 0 then
  sleep(timeout)
 end
 
 return false, "timeout"
end

--[[ Getters And Setters ]]--

--+ TimeFormat +--

function setTimeFormat(formatTable)
 if formatTable then
  format = ""
  
  for i=1, #formatTable do
   if formatTable[i] then
    format = format .. formatTable[i]
   end
  end
  
  return true
 end
 
 return false
end

function getTimeFormat()
 return format
end

--+ Website +--

function setWebsite(_website)
 if website then
  website = _website
  
  return true
 end
 
 return false
end

function getWebsite()
 return website
end

--+ Website params +--

function setWebsiteParams(_websiteParams)
 if _websiteParams then
  websiteParams = websiteParams
  
  return true
 end
 
 return false
end

--+ Timeout +--

function setTimeout(_timeout)
 if _timeout and type(_timeout) == "number" then
  timeout = _timeout
 
 return true
 end
 
 return false
end

function getTimeout()
 return timeout
end

--[[ Functions ]]--

function string:Time(_data, _website, _timezone, _websiteParams, _timeout)
 data = _data or {get(true, _website, _timezone, _websiteParams, _timeout)}
 
 if data[1] ~= true then return data[1], data[2] end
 
 for i=1, #data do
  self = self:gsub("%"..tostring(i), data[i])
 end
 
 return self
end

function get(tableFormatIsInNumbers, _website, _timezone, _websiteParams, _timeout)
 local website, timezone, websiteParams, timeout = _website or website, _timezone or timezone, _websiteParams or websiteParams, _timeout or timeout
 local httpAddress = website .. timezone .. websiteParams
 local ok, data = parallel.waitForAny(getWebsite(website), initTimer(timeout))
 
 if not ok then return ok, data end
 
 local websiteData = textutils.unserialize(http.get(data))
 local data = {}
 
 if tableFormatIsInNumbers then
  data = {websiteData["sec"], websiteData["time"], websiteData["day"], websiteData["month"], websiteData["year"]}
 else
  data = {["sec"] = websiteData["sec"], ["time"] = websiteData["time"], ["day"] = websiteData["day"], ["month"] = websiteData["month"], ["year"] = websiteData["year"]}
 end
 
 return ok, data
end