local format = "^2:^1 ^4 ^3 ^5"
local website = "http://www.timeapi.org/"
local timezone = "utc/"
local websiteParams = "now?format={[%22sec%22]=%25S,%20[%22time%22]=%22%25H:%25M%22,%20[%22day%22]=%25d,%20[%22month%22]=%22%25b%22,%20[%22year%22]=%25Y}"

if not http then error("TimeAPI: HTTP API Not Enabled! TimeAPI Disabled!", 0) end

-- Getters And Setters

-- TimeFormat

function setTimeFormat(_timeFormat)
 if str then
  format = _timeFormat
  return true
 end
 return false
end

function getTimeFormat()
 return format
end

-- Website

function setWebsite(_website)
 if website then
  website = _website
  return true
 end
 return false
end

-- Functions

function string:Time()
 data = data or get(true)
 
 for i=1, #data do
  str = str:gsub("%^"..tostring(i), data[i])
 end
 
 return str
end

function get(tableFormatIsInNumbers, _website, _timezone, _websiteParams)
 local website, timezone, websiteParams = _website or website, _timezone or timezone, _websiteParams or websiteParams
 local httpAddress = website .. timezone .. websiteParams
 local websiteData = textutils.unserialize(http.get(httpAddress).readAll())
 local data = {}
 
 if tableFormatIsInNumbers then
  data = {websiteData["sec"], websiteData["time"], websiteData["day"], websiteData["month"], websiteData["year"]}
 else
  data = {["sec"] = websiteData["sec"], ["time"] = websiteData["time"], ["day"] = websiteData["day"], ["month"] = websiteData["month"], ["year"] = websiteData["year"]}
 end
 
 return data
end