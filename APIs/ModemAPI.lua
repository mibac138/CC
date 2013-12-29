local Version = 0

-- Functions

function getSides()
  local sides = {}
  
  for _, s in ipairs(rs.getSides()) do
   table.insert(sides, s)
  end
  
  return sides
end


function getPeripherals()
 peripherals = {}
 
 for _,s in ipairs(rs.getSides()) do
  if peripheral.isPresent(s) then
   table.insert(sides, s)
  end
 end
 
 return s
end


function getPeripheral(PeripheralName)
 for _,s in ipairs(rs.getSides()) do
  if PeripheralName == s then
   if peripheral.isPresent(s) then
    PeripheralName = peripheral.getType(s)
    return s, PeripheralName
   end
  end
 end
 
 peripherals = {}
 
 for _,s in ipairs(rs.getSides()) do
  if peripheral.isPresent(s) and peripheral.getType(s) == PeripheralName then
   table.insert(peripherals, s)
  end
 end
 
 return peripherals
end


function getModems()
 return getPeripheral("modem")
end

function openModem(side)
 modems = {getModems()}
 for i = 1, #modems do
  if modems[i] == side and not rednet.isOpen(modems[i]) then
   rednet.open(side)
  end
 end
end

function sendMsg(Msg, encrypted)
 
end