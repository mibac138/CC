local GitHubURL = "https://github.com"
local GitHubSourceURL = "https://raw.github.com"
local GitHubUserName = "mibac138"
local GitHubRepoName = "CC"
local GitHubFileName



if not http then
 error("GitHubAPI: HTTP API Not Enabled! GitHubAPI Disabled!", 0)
else

 -- Helper Functions

 local function getWebsite(WebsiteURL)
  Website = http.get(WebsiteURL)
  return Website or false
  end

 -- Getters And Setters

 -- GitHubUserName

 function setGitHubUserName(_GitHubUserName)
  local GitHubUserName = tostring(_GitHubUserName)
 end
 
 function getGitHubUserName()
  return GitHubUserName
 end

 -- GitHubURLAddress

 function setGitHubURLAddress(_GitHubURL)
  local _GitHubURL = tostring(_GitHubURL)
 
  if not string.sub(_GitHubURL, 1, 7) == "http://" then
   _GitHubURL = "http://" .. _GitHubURL
  end
 
  GitHubURL = _GitHubURL
 end

 function getGitHubURLAddress()
  return GitHubURL
 end

 -- GitHubSourceURLAddress

 function setGitHubSourceURLAddress(_GitHubSourceURL)
  local _GitHubSourceURL = tostring(_GitHubSourceURL)
 
  if not string.sub(_GitHubSourceURL, 1, 7) == "http://" then
   _GitHubSourceURL = "http://" .. _GitHubSourceURL
  end
 
  GitHubSourceURL = _GitHubSourceURL
 end

 function getGitHubSourceURLAddress()
  return GitHubSourceURL
 end

 -- GitHubRepo[sitory]Name

 function setGitHubRepoName(_GitHubRepoName)
  GitHubRepoName = tostring(_GitHubRepoName)
 end

 function getGitHubRepoName()
  return GitHubRepoName
 end

 setGitHubRepositoryName = setGitHubRepoName

 -- GitHubFileName
 
 function setGitHubFileName(_GitHubFileName)
  GitHubFileName = tostring(_GitHubFileName)
 end

 function getGitHubFileName()
  return GitHubFileName
 end
 
 -- Functionality Functions

 function GitHubFileDownload(_GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubFileName)
  local _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubFileName = _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubFileName or GitHubFileName
 
  local Website = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/master/" .. _GitHubFileName)
  if Website == false then error("GitHubAPI: Cannot connect to website!", 0) end
  
  local WebsiteData = Website.readAll()
  return WebsiteData
 end
 
 function GitHubFileDownloadIf(p1, p2, p3, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubFileName)
  local _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubFileName, canDownload = _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubFileName or GitHubFileName, false
 
  if p3 == "==" and p1 == p2 then canDownload = true
  elseif p3 == ">=" and p1 >= p2 then canDownload = true
  elseif p3 == "<=" and p1 <= p2 then canDownload = true
  elseif p3 == "~=" and p1 ~= p2 then canDownload = true
  elseif p3 == ">" and p1 > p2 then canDownload = true
  elseif p3 == "<" and p1 < p2 then canDownload = true
  end
  
  if canDownload == true then
   local Website = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/master/" .. _GitHubFileName)
   if Website == false then error("GitHubAPI: Cannot connect to website!", 0) end
   
   local WebsiteData = Website.readAll()
   return WebsiteData, canDownload
  else
   return canDownload
  end
 end
 
 function GitHubFileDownloadIfExistsUpdate(_FileWhereToSave, _FileName, _FileVersion, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName)
  if not _FileWhereToSave then error("GitHubAPI: REQUIRED arg [1] - File Where To Save", 0) end
  local _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _FileName, _FileVersion = _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _FileName or GitHubFileName, _FileVersion or 1.0
  local VersionCheck = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/master/ProgramVersions")
  if VersionCheck == false then error("GitHubAPI: Cannot connect to website!", 0) end
  
  VersionCheck = textutils.unserialize(VersionCheck.readAll())
  
  if not VersionCheck[tostring(_FileName)] then return false, "File isnt existing in ProgramVersions db file (" .. _GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/master/ProgramVersions)" end
  
  if VersionCheck[tostring(_FileName)].Version > _FileVersion then -- Just For Sure (tostring)
   
   local Website = getWebsite(VersionCheck[_FileName].GitURL)
   if Website == false then error("GitHubAPI: Cannot connect to website!", 0) end
   
   local WebsiteData = Website.readAll()
   
   return WebsiteData, "Update Founded And Downloaded"
  else
   return false, "No update found"
  end
 end
end