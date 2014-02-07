--[[
 My, mibac138 small Time API.
 
]]

local Version = 1.0
local format = "2:1 4 3 5"
local website = "http://www.timeapi.org"
local timezone = "utc"
local websiteParams = "now?format={%22%25S%22,%20%22%25H:%25M%22,%20%22%25d%22,%20%22%25b%22,%20%22%25Y%22}"

if not http then error("TimeAPI: HTTP API Not Enabled! TimeAPI Disabled!", 0) end

--[[ Helper Functions ]]--

local function getWebsite(httpAddress)
 if not http then return false, "HTTP API Not Enabled!" end
 ok, data = false, nil
 
 ok, data = pcall(function() return http.get(httpAddress).readAll() end)
 
 return ok, data
end

--[[ Getters And Setters ]]--

--+ TimeFormat +--

function setTimeAPITimeFormat(formatTable)
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

function getTimeAPITimeFormat()
 return format
end

--+ Website +--

function setTimeAPIWebsite(_website)
 if website then
  website = _website
  
  return true
 end
 
 return false
end

function getTimeAPIWebsite()
 return website
end

--+ Website params +--

function setTimeAPIWebsiteParams(_websiteParams)
 if _websiteParams then
  websiteParams = websiteParams
  
  return true
 end
 
 return false
end

--+ Timeout +--

function setTimeAPITimeout(_timeout)
 if _timeout and type(_timeout) == "number" then
  timeout = _timeout
 
 return true
 end
 
 return false
end

function getTimeAPITimeout()
 return timeout
end

--+ Version +--

function getTimeAPIVersion()
 return Version
end

--[[ Functions ]]--

function getTime(str, _website, _timezone, _websiteParams)
 ok, data = getRawTime(true, _website, _timezone, _websiteParams)
 
 if not ok then return ok, data end
 
 for i=1, #data do
  str = string.gsub(str, "%^"..i, tostring(data[i]))
  --print(str)
 end

 return str
end

function string:getTime(_website, _timezone, _websiteParams)
 ok, data = getRawTime(true, _website, _timezone, _websiteParams)
 
 if not ok then return ok, data end
 
 for i=1, #data do
  self = string.gsub(self, "%^"..i, tostring(data[i]))
  --print(str)
 end

 return self
end

function getRawTime(tableFormatIsInNumbers, _website, _timezone, _websiteParams)
 local website, timezone, websiteParams, httpAddress = _website or website, _timezone or timezone, _websiteParams or websiteParams, website .. "/" .. timezone .. "/" .. websiteParams
 
 ok, _data = getWebsite(httpAddress)
 
 if not ok then return ok, _data end
 
 if tableFormatIsInNumbers then
  return ok, textutils.unserialize(_data)
 else
  data = {["sec"] = _data[1], ["time"] = _data[2], ["day"] = _data[3], ["month"] = _data[4], ["year"] = _data[5]}
  
  return ok, data
 end

 return ok, data
end