--[[
 My, mibac138 GitHub API.
]]

local Version = 1.1
local GitHubURL = "https://github.com"
local GitHubSourceURL = "https://raw.github.com"
local GitHubUserName = "mibac138"
local GitHubRepoName = "CC"
local GitHubBranchName = "master"
local GitHubVersionsFileName = "Versions"
local GitHubFileName



if not http then
 error("GitHubAPI: HTTP API Not Enabled! GitHubAPI Disabled!", 0)
else

 --[[ Helper Functions ]]--

local function getWebsite(_website)
 if not http then return false, "HTTP API Not Enabled!" end
 website = _website or website
 ok, data = pcall(function(website) return http.get(website).readAll() end)
 
 return ok, data
end

 
 --[[ Getters And Setters ]]--

 --+ GitHubUserName +--

 function setGitHubUserName(_GitHubUserName)
  if not (_GitHubUserName == nil and _GitHubUserName == "") then
   GitHubUserName = tostring(_GitHubUserName)
   
   return true
  end
  
  return false
 end
 
 function getGitHubUserName()
  return GitHubUserName
 end

 --+ GitHubURLAddress +--

 function setGitHubURLAddress(_GitHubURL) 
  if not _GitHubURL:sub(1, 7) == "http://" then
   _GitHubURL = "http://" .. _GitHubURL
  end
  
  if not (_GitHubURL == nil and _GitHubURL == "" and _GitHubURL == "http://" and _GitHubURL == "https://") then  
   GitHubURL = tostring(_GitHubURL)
   
   return true
  end
  
  return false
 end

 function getGitHubURLAddress()
  return GitHubURL
 end

 --+ GitHubSourceURLAddress +--

 function setGitHubSourceURLAddress(_GitHubSourceURL)  
  if not string.sub(_GitHubSourceURL, 1, 7) == "http://" then
   _GitHubSourceURL = "http://" .. _GitHubSourceURL
  end
  
  if not (_GitHubSourceURL == nil and _GitHubSourceURL == "" and _GitHubSourceURL == "http://" and _GitHubSourceURL == "https://") then 
   GitHubSourceURL = _GitHubSourceURL
   
   return true
  end
  
  return false
 end

 function getGitHubSourceURLAddress()
  return GitHubSourceURL
 end

 --+ GitHubRepo[sitory]Name +--

 function setGitHubRepoName(_GitHubRepoName)
  if not (_GitHubURL == nil and _GitHubURL == "") then  
   GitHubRepoName = tostring(_GitHubRepoName)
   
   return true
  end
  
  return false
 end

 function getGitHubRepoName()
  return GitHubRepoName
 end

 setGitHubRepositoryName = setGitHubRepoName
 getGitHubRepositoryName = getGitHubRepoName

 --+ GitHubFileName +--
 
 function setGitHubFileName(_GitHubFileName)
  if not (_GitHubFileName == nil and _GitHubFileName == "") then
   GitHubFileName = _GitHubFileName
   
   return true
  end
  
  return false
 end

 function getGitHubFileName()
  return GitHubFileName
 end
 
 --+ GitHubBranchName +--
 
 function setGitHubBranchName(_GitHubBranchName)
  if not (_GitHubBranchName == nil and _GitHubBranchName == "") then
   GitHubBranchName = _GitHubBranchName
   
   return true
  end
  
  return false
 end

 function getGitHubBranchName()
  return GitHubBranchName
 end
 
  --+ GitHubVersionsFileName +--
 
 function setGitHubVersionsFileName(_GitHubVersionsFileName)
  if not (_GitHubVersionsFileName == nil and _GitHubVersionsFileName == "") then
   GitGitHubVersionsFileName = _GitHubVersionsFileName
   
   return true
  end
  
  return false
 end

 function getGitHubVersionsFileName()
  return GitHubBranchName
 end
 
 --[[ Functions ]]--

 function GitHubFileDownload( _GitHubFileName, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName)
  local _GitHubFileName, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName = _GitHubFileName or GitHubFileName, _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubBranchName or GitHubBranchName
  
  if _GitHubFileName == nil or _GitHubFileName == "" then error("GitHubAPI: REQUIRED arg [1] - Git Hub File Name" ,0) end
  
  local Website = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/" .. _GitHubBranchName .. "/" .. _GitHubFileName)
  if Website == false then error("GitHubAPI: Cannot connect to website!", 0) end
  
  local WebsiteData = Website.readAll()
  
  return WebsiteData
 end
 
 function GitHubFileDownloadIf(p1, p2, p3, _GitHubFileName, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName)
  local _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubFileName, _GitHubBranchName, canDownload = _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubFileName or GitHubFileName, _GitHubBranchName or GitHubBranchName , false
  
  if not p1 or not p2 or not p3 then return false, "p1, p2, or p3 is nil" end
  
  if p3 == "==" and p1 == p2 then canDownload = true
  elseif p3 == ">=" and p1 >= p2 then canDownload = true
  elseif p3 == "<=" and p1 <= p2 then canDownload = true
  elseif p3 == "~=" and p1 ~= p2 then canDownload = true
  elseif p3 == ">" and p1 > p2 then canDownload = true
  elseif p3 == "<" and p1 < p2 then canDownload = true
  end
  
  if canDownload == true then
   local Website = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/" .. _GitHubBranchName .. "/" .. _GitHubFileName)
   if Website == false then error("GitHubAPI: Cannot connect to website!", 0) end
   
   local WebsiteData = Website.readAll()
   
   return WebsiteData, canDownload
  else
  
   return canDownload
  end
 end
 
 function GitHubFileDownloadIfExistsUpdate(_FileWhereToSave, _FileName, _FileVersion, _GitHubVersionsFileName, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName)
  if not _FileWhereToSave then error("GitHubAPI: REQUIRED arg [1] - File Where To Save", 0) end
  
  local _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName, __GitHubVersionsFileName, _FileName, _FileVersion = _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubBranchName or GitHubBranchName, _GitHubVersionsFileName or GitHubVersionsFileName, _FileName or GitHubFileName, _FileVersion or 1.0
  
  local VersionCheck = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/" .. _GitHubBranchName .. "/" .. _GitHubVersionsFileName)
  
  if VersionCheck == false then error("GitHubAPI: Cannot connect to website!", 0) end
  
  VersionCheck = textutils.unserialize(VersionCheck.readAll())
  
  if not VersionCheck[tostring(_FileName)] then return false, "File isnt existing in " .. _GitHubVersionsFileName .. " db file (" .. _GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/" .. _GitHubBranchName .. "/" .. _GitHubVersionsFileName)" end
  
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
