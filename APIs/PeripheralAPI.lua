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
 peripherals = {}
 
 for _,s in ipairs(rs.getSides()) do
  if peripheral.isPresent(s) and peripheral.getType() == PeripheralName then
   table.insert(peripherals, s)
  end
 end
 
 return peripherals
end