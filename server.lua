--[[
    vRP.Construction module
    original idea by Curtis A Henson & Otis 2018 (SALife)
    code copied and modified by ZhivGaming into a stand alone market/job
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Dclient = Tunnel.getInterface("vrp_construction")
Tunnel.bindInterface("vrp_construction",vRPd)

local cfg = module("vrp_construction", "cfg/products")

Citizen.CreateThread(function()
  for k,v in pairs(cfg.products) do
    vRP.defInventoryItem(k,v.name,v.desc,v.choices,v.weight)
  end
end)

local products = {
    "stone",
    "gravel",
    "cement",
    "concrete",
    "sand",
    "asphalt",
    "tar"
}

local prices = {
    3,
    5,
    5,
    15,
    3,
    15,
    20,
    8
}

local stonect = 0;
local gravelct = 0;
local cementct = 0;
local concretect = 0;
local sandct = 0;
local asphaltct = 0;
local tarct = 0;

-- delivery points

local constSites = {}
local constSitesPos = {
  {303.8962,  2840.5146, 43.0946, "SCW Harmony"},
  {-157.5418, -985.1436, 20.9236, "Mile High Club"},
  {-472.6753, -1008.136, 23.1937, "Calais Ave"},
  {81.5444,   -334.8227, 43.1294, "Power St"},
  {56.4469,   -421.5430, 39.5667, "Power St"},
  {321.4464,  -1899.034, 26.0348, "Carson Ave Tunnel"},
  {33.9752,   -611.4423, 31.2764, "UD Subway Project"},
  {1397.3392, -756.4749, 66.9091, "Mirror Park"}
}

local steelSites = {}
local steelSitesPos = {
    {-141.4518, -1002.455, 26.9216, "Mile High Club"},
    {-204.0301, -1098.699, 21.4023, "Mile High Club"},
    {-454.2738, -986.4075, 23.1923, "Calais Ave"},
    {134.8626,  -376.4774, 24.9039, "Power St"},
    {47.4922,   -446.9142, 39.5662, "Power St"},
    {321.4464,  -1899.034, 26.0348, "Carson Ave Tunnel"},
    {33.9752,   -611.4423, 31.2764, "UD Subway Project"}
}

local cementCheckIn = {}
local cementCheckInPos = {
    {286.6020,  2843.8125, 44.7041, "SCW Harmony"},
    {1244.2161, 1866.3274, 79.1486, "SCW Senora"}
}

local cementPickup = {}
local cementPickupPos = {
    {274.3790,  2883.1167, 43.2566, "SCW Harmony"},
    {1229.5767, 1896.4709, 78.2795, "SCW Senora"}
}

local logsPickup = {}
local logsPickupPos = {
    {-672.9578, 5480.5527, 49.4558, "Paleto Lumber 1"},
    {-611.8715, 5510.2061, 49.9572, "Paleto Lumber 2"},
    {2484.0381, 4617.9146, 35.4580, "Grapeseed Farm"},
    {186.5532,  4419.2065, 73.7571, "Mount Chiliad"}
}

local lumberDeliveries = {}
local lumberDeliveriesPos = {
    {2675.3123, 3521.5278, 52.2756, "You Tool Senora"},
    {109.4857, 6531.9443, 31.0110, "Paleto Const Site"},
    {103.4705, -1816.894, 26.1115, "MegaMart Davis"},
    {1397.3392, -756.4749, 66.9091, "Mirror Park"},
    {115.2055, -2654,188, 5.5926, "Allied Shipyard"}
}

-- init

Citizen.CreateThread(function()
    for k,v in pairs(products) do
        local prodKey = "vRP:"..tostring(v)
        local prodAmt = json.decode(vRP.getSData(prodKey))
        print(prodKey .. " = " .. prodAmt)
        if not prodAmt then
            print("FIRST INIT: " .. prodKey .. " = " .. prodAmt)
            vRP.setSData(prodKey, json.encode(0))
        else
            vRP.setSData(prodKey, json.encode(prodAmt))
        end
    end
end)

function getStoneCount()
    local data23 = vRP.getSData("vRP:stone")
    local stonect = json.decode(data23) or {}
    return stonect
end

function getGravelCount()
    local data24 = vRP.getSData("vRP:gravel")
    local gravelct = json.decode(data24) or {}
    return gravelct
end

function getCementCount()
    local data25 = vRP.getSData("vRP:cement")
    local cementct = json.decode(data25) or {}
    return cementct
end

function getConcreteCount()
    local data26 = vRP.getSData("vRP:concrete")
    local concretect = json.decode(data26) or {}
    return concretect
end

function getSandCount()
    local data27 = vRP.getSData("vRP:sand")
    local sandct = json.decode(data27) or {}
    return sandct
end

function getAsphaltCount()
    local data28 = vRP.getSData("vRP:asphalt")
    local asphaltct = json.decode(data28) or {}
    return asphaltct
end

function getTarCount()
    local data29 = vRP.getSData("vRP:tar")
    local tarct = json.decode(data29) or {}
    return tarct
end

function reportCounts(p)
    local debugstring = ""
    
    for k,v in pairs(products) do
        local idname = tostring(v)
        local prodKey = "vRP:" .. idname
        local prodAmt = json.decode(vRP.getSData(prodKey))
    end
    
    TriggerClientEvent('chatMessage', p, "", {50,100,200}, debugstring)
    -- PerformHttpRequest('https://discordapp.com/api/webhooks/443969050905935894/7ldi-CD6eFWkZjTjFx7zpA2JwgBwhtdy8_bo_BIQOeyRUh6mo28VO8JksIHO6uvsFAhB', function(err, text, headers) end, 'POST', json.encode({username = "Construction Market", content = debugstring}), {['Content-Type'] = 'application/json'}) 
    
    PerformHttpRequest('https://discordapp.com/api/webhooks/523318213199527936/_dvwqRMNegQrLL48pyAoR1QWTr-2QsKuBV7V6cDM1k2TpZvkbtYdQPV7q-Pnl5XTsVYW', function(err, text, headers) end, 'POST', json.encode({username = "Construction Market", content = debugstring}), {['Content-Type'] = 'application/json'}) 
    
end

local rockCrusher = {
    name = "Rock Crusher", -- menu name
    permission = {},
    r=0,g=200,b=0, -- color
    max_units=20,
    units_per_minute=16,
    x=2681.53459,y=2800.2014,z=40.3612,radius=10,height=1.5, -- area
    recipes = {
        ["Crush Rocks"] = { -- action name
            description="Make Gravel", -- action desc
            in_money=0.5, -- money taken per unit
            out_money=2, -- money earned per unit
            reagents={  -- items taken in
                ["stone"] = 5
            }, 
            products={  -- items created
                ["gravel"] = 4
            },
            aptitudes={ }
        },
        ["Crush Gravel"] = {
            description="Make Sand", -- action desc
            in_money=0.5,   -- money taken in per unit
            out_money=2,    -- money earned per unit
            reagents={      -- items taken in
                ["gravel"] = 4
            },
            products={      -- items created
                ["sand"] = 3
            },
            aptitudes={ }
        }
    }, 
}

local stonepiles = {}
local stonepilepos = {
    {2681.53459, 2800.2014,  40.3612},
}

function createStonepiles()

    for k,v in pairs(stonepilepos) do
        local pos = v
        local ax, ay, az = table.unpack(pos)
        local stones = {
            name = "Mine Stone", -- menu name
            r=0, g=200, b=0, -- color
            max_units = 60,
            units_per_minute=8,
            x=ax, y=ay, z=az,
            radius=10, height=1.5, --area
            recipes={
                ["Mine Stones"] = { -- action descriptor
                    in_money=0,   -- money taken per unit
                    out_money=0,  -- money earned per unit
                    reagents={ }, -- items taken per unit
                    products={    -- items given per unit
                        ["stones"] = 1
                    },
                    aptitudes={
                        ["skill.mining"] = 0.01
                    }
                }
            },
            onstart = function(player,recipe)
                if not vRPclient.isInVehicle(player) then
                    vRPclient.playAnim(player,false,{task="WORLD_HUMAN_CONST_DRILL"},false)
                    Citizen.Wait(20000)
                    vRPclient.stopAnim(player,false)
                end
            end,
            onstep = function(player,recipe)
                local user_id = vRP.getUserId(player)
                local ok,vname = vRPclient.getNearestOwnedVehicle(player,15)
                if not ok then
                    if vRP.hasPermissions(user_id, {"@skill.mining.>16"}) then
                        vRP.giveInventoryItem(user_id, "stone", 1, true)
                        vRPclient.notify(player, "You receive ~g~1~w~ additional ~g~stone")
                    end
                else
                    if vRPclient.isPlayerInVehicleModel(player,"tiptruck2") then
                        if vRP.addToVehicleTrunk(user_id, vname, "stone", 3) == false then
                            vRP.giveInventoryItem(user_id,"stone",3,true)
                        end
                      vRPclient.notify(player, "You receive ~g~3~w~ additional ~g~Stone!")
                    elseif vRPclient.isPlayerInVehicleModel(player, "tiptruck") then
                        if vRP.addToVehicleTrunk(user_id, vname, "stone", 2) == false then
                            vRP.giveInventoryItem(user_id, "stone", 2, true)
                        end
                      vRPclient.notify(player, "You receive ~g~2~w~ additional ~g~Stone!")
                    elseif vRPclient.isPlayerInVehicleModel(player, "rubble") then
                        if vRP.addToVehicleTrunk(user_id, vname, "stone", 3) == false then
                            vRP.giveInventoryItem(user_id, "stone", 3, true)
                        end
                      vRPclient.notify(player, "You receive ~g~3~w~ additional ~g~Stone!")
                    elseif vRP.hasPermissions(user_id, {@skill.mining.>16"}) then
                        if vRP.addToVehicleTrunk(user_id, vname, "stone", 1) == false then
                            vRP.giveInventoryItem(user_id, "stone", 1, true)
                        end
                      vRPclient.notify(player, "You receive ~g~1~w~ additional ~g~Stone!")
                    end
                end
            end,
        }
        table.insert(stonepiles, stones)
    end
    
    local count = 0
    for l,w in pairs(stonepiles) do
        vRP.setItemTransformer("stones" .. l, w)
        count = count + 1
    end
    print(count .. " stone piles loaded")
end

function createConstruction()
  create Stonepiles()
  
  vrp.setItemTransformer("mineralsmarket", itemtr)
end

-- add additional static blips/markers

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    for k,v in pairs(cementCheckInPos) do -- location of cement job checkin
      local pos = v
      local ax,ay,az,aloc = table.unpack(pos)
      vRPclient._addMarker(source, ax, ay, az-1,4,4,0.75,64,0,0,150,35)
    end
    for k,v in pairs(constCheckInPos) do -- location of construction dispatch checkin
      local pos = v
      local ax,ay,az,aloc = table.unpack(pos)
      vRPclient._addMarker(source, ax, ay, az-1,4,4,0.75,64,0,0,150,35)
    end
    
    -- cement job checkin locations
    vRPclient._addBlip(source, 286.6020, 2843.8125, 44.7041, 285, 56, "SCW Senora")
    vRPclient._addBlip(source, 1244.2161, 1866.3274, 79.1486, 285, 56, "SCW Harmony")
    
    -- dump truck dispatch checking location
    vRPclient._addBlip(source, x, y, z, 285, 56, "Aggregate Hauling")
  end
end)

Citizen.CreateThread( function()
    createConstruction()
end)
  
    

    