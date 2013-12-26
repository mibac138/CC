local GitHubHttp = "http://github.com"
local GitHubSourceHttp = "http://raw.github.com"
local GitHubUserName = "mibac138"

function setGitHubUserName(user)
 user = tostring(user)
 GitHubUserName = user
end

function getGitHubUserName()
 return GitHubUserName
end

function setGitHubHttpAddress(GitHubHttp)
 GitHubHttp = tostring(GitHubHttp)
 if not string.sub(GitHubHttp, 1, 7) == "http://" then
  GitHubHttp = "http://" .. GitHubHttp
 end
 
end