tbl = {10,20,30,40}
local var = 1
for key, value in pairs(tbl) do
   
    print(var.." "..value)
    var = value
end
