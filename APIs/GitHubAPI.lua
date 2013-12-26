local GitHubHttp = "http://github.com"
local GitHubSourceHttp = "http://raw.github.com"
local GitHubUserName = "mibac138"
local GitHubRepoName = "CC"

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