Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

--tvRP = {}
--Tunnel.bindInterface("vRP",tvRP) 

vRPfm = {}
vRP = Proxy.getInterface("vRP")
FMserver = Tunnel.getInterface("vrp_construction")
vRP = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_construction",vRPconst)
Proxy.addInterface("vrp_construction",vRPconst)