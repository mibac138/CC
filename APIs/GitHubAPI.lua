local GitHubHttp = "https://github.com"
local GitHubSourceHttp = "https://raw.github.com"
local GitHubUserName = "mibac138"
local GitHubRepoName = "CC"
local GitHubFileName

-- Just For Sure

if not http then
 error("GitHubAPI: HTTP API Not Enabled! GitHubAPI Disabled!", 12)
else

 -- Helper Functions

 local function getWebsite(WebsiteHttp)
  Website = http.get(WebsiteHttp)
  return Website
 end

 -- Getters And Setters

 -- GitHubUserName

 function setGitHubUserName(_GitHubUserName)
  local GitHubUserName = tostring(_GitHubUserName)
 end
 
 function getGitHubUserName()
  return GitHubUserName
 end

 -- GitHubHttpAddress

 function setGitHubHttpAddress(_GitHubHttp)
  local _GitHubHttp = tostring(_GitHubHttp)
 
  if not string.sub(_GitHubHttp, 1, 7) == "http://" then
   _GitHubHttp = "http://" .. _GitHubHttp
  end
 
  GitHubHttp = _GitHubHttp
 end

 function getGitHubHttpAddress()
  return GitHubHttp
 end

 -- GitHubSourceHttpAddress

 function setGitHubSourceHttpAddress(_GitHubSourceHttp)
  local _GitHubSourceHttp = tostring(_GitHubSourceHttp)
 
  if not string.sub(_GitHubSourceHttp, 1, 7) == "http://" then
   _GitHubSourceHttp = "http://" .. _GitHubSourceHttp
  end
 
  GitHubSourceHttp = _GitHubSourceHttp
 end

 function getGitHubSourceHttpAddress()
  return GitHubSourceHttp
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

 function GitHubFileDownload(_GitHubSourceHttp, _GitHubUserName, _GitHubRepoName, _GitHubFileName)
  local _GitHubSourceHttp, _GitHubUserName, _GitHubRepoName, _GitHubFileName = _GitHubSourceHttp or GitHubSourceHttp, _GitHubUserName or GitHubUserName, _GitHubRepoName or GitHubRepoName, _GitHubFileName or GitHubFileName
 
  local Website = http.get(_GitHubSourceHttp .. "/" .. _GitHubUserName .. "/" .. _GitHubRepoName .. "/master/" .. _GitHubFileName)
 
  local WebsiteData = Website.readAll()
  return WebsiteData
 end
 
end




