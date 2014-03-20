--[[
 My, mibac138 GitHub API.
 
]]

local Version = 1.2
local GitHubURL = "https://github.com"
local GitHubSourceURL = "https://raw.github.com"
local GitHubUserName = "mibac138"
local GitHubRepoName = "CC"
local GitHubBranchName = "master"
local GitHubVersionsFileName = "Versions.lua"
local GitHubFileName


--[[ Helper Functions ]]--

local function getWebsite(httpAddress)
 if not http then return false, "HTTP API Not Enabled!" end
 ok, data = false, nil
 
 ok, data = pcall(function() return http.get(httpAddress).readAll() end)
 
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
 
--+ Version +--
 
function getGitHubAPIVersion()
 return Version
end
 
--[[ Functions ]]--

function GitHubFileDownload( _GitHubFileName, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName)
 local _GitHubFileName, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName = _GitHubFileName or GitHubFileName, _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubBranchName or GitHubBranchName
 if type(_GitHubFileName) == "table" then
  _GitHubFileName = _GitHubFileName["GitHubFileName"] or _GitHubFileName
 end
 
 if not _GitHubFileName or _GitHubFileName == "" then error("GitHubAPI: REQUIRED arg [1] - Git Hub File Name", 0) end
 
 local ok, data = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/" .. _GitHubBranchName .. "/" .. _GitHubFileName)
 
 if not ok then return ok, data end
 
 return data
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
  
 if canDownload then
 
  local ok, data = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/" .. _GitHubBranchName .. "/" .. _GitHubFileName)
  
  if not ok then return ok, data end
  
  return canDownload, data
 else
 
  return canDownload
 end
end
 
function GitHubFileDownloadIfExistsUpdate(_FileWhereToSave, _FileName, _FileVersion, _GitHubVersionsFileName, _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName)
 local _GitHubSourceURL, _GitHubUserName, _GitHubRepoName, _GitHubBranchName, __GitHubVersionsFileName, _FileName, _FileVersion = _GitHubSourceURL or GitHubSourceURL, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubBranchName or GitHubBranchName, _GitHubVersionsFileName or GitHubVersionsFileName, _FileName or GitHubFileName, _FileVersion or 1.0
 
 local ok, data = getWebsite(_GitHubSourceURL .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/" .. _GitHubBranchName .. "/" .. _GitHubVersionsFileName)
 
 if not ok then return ok, data end
 
 data = textutils.unserialize(data)
 
 if not data[tostring(_FileName)] then return ok, data end
 
 if data[tostring(_FileName)].Version > _FileVersion then
  
  local ok, data = getWebsite(data[_FileName].GitURL)
  
  if not ok then return ok, data end
  
  return ok, data, "Update Founded And Downloaded"
 else
  return ok, "No update found"
 end
end
