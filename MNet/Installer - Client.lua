local installDir = "/MNet"
local dupliFilesDir = "/Conflicted_Files"
local canClr = false
local done = false
local InstallationProgress = 1
local InstallationSteps = {[1] = {name = "Starting Installer"}; [2] = {name = "Creating Files"}; [3] = {name = "Ending Installation"};}
local files = {[1] = {name = "Client"; data = [[print("test1")]]}; [2] = {name = "API"; data= [[print("test2")]]};}
local x, y = term.getSize()
if term.isColor then canClr = true else canClr = false end
if not x == 51 and not y == 19 then if(canClr) then term.setTextColor(colors.red) print("Error! Unsupported monitor size!") else print("Error! Unsupported monitor size!") end end

local function printCentered(text, line)
 term.setCursorPos(math.floor((51 / 2) - (#text /2)), line)
 print(text)
 return (51 / 2) - string.len(text), line
end

local function completeLineWith(text)
 for i=1, math.floor(51 / string.len(text)) do
  write(text)
 end
end

local function drawBg()
 term.setBackgroundColor(colors.blue)
 term.clear()
 term.setCursorPos(1,1)
 term.setTextColor(colors.black)
 term.setBackgroundColor(colors.white)
 term.clearLine()
 term.setCursorPos(1,2)
 term.clearLine()
 term.setCursorPos(1,3)
 term.clearLine()
 term.setCursorPos(1,1)
 
 if not done then
  printCentered("MNet Installer - Installing", 1)
  printCentered("Currently Doing: " ..InstallationSteps[InstallationProgress].name .. " (" .. InstallationProgress .. " / " .. #InstallationSteps .. ")", 2)
 else
  printCentered("MNet Installer - Done", 1)
 end
 
 completeLineWith("-")
 term.setBackgroundColor(colors.blue)
 term.setTextColor(colors.white)
end

drawBg()
X, Y = printCentered("Where To Install [/MNet] ?", 5)
term.setCursorPos(X, Y+1)
input = read()
if not input == "" then installDir = input end

for i=1, #files do
 files[i].dir = installDir .. "/" .. files[i].name
end

drawBg()
InstallationProgress = 2
drawBg()

if not fs.exists(installDir) then fs.makeDir(installDir) end

for i = 1, #files do
 fileName = files[i].dir
 fileData = files[i].data
 
 if fs.exists(fileName) then 
  if not fs.exists(dupliFilesDir) then fs.makeDir(dupliFilesDir) end
  if fs.exists(dupliFilesDir .. "/" .. files[i].name) then
   count = 1
   while fs.exists(dupliFilesDir .. "/" .. files[i].name .. "(" .. count .. ")") do
    count = count + 1
   end
  
   fs.move(fileName, dupliFilesDir .. "/" .. files[i].name .. "(" .. count .. ")")
   count = nil
  else
   fs.move(fileName, dupliFilesDir .. "/" .. files[i].name)
  end
 end
 
 file = assert(fs.open(fileName, "w"), "Couldn't open file ".. fileName)
 file.write()
 file.close()
end

InstallationProgress = 3
drawBg()

printCentered("Installation Complete. Rebooting in 5 seconds", 5)

sleep(5)

os.reboot()
