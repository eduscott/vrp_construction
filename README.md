## Still a WIP ##

# vrp_construction
adds a construction materials crafting and delivery job to vRP (FiveM)

# The plain and simple explanation
This allows your citizens to deliver and manufacture various construction materials for the State of San Andreas

# Commodities
- Sand
- Clay (used to manufacture bricks)
- Gravel
- Stone
- Coal
- Iron
- Steel (Beams, Rebar, Nails, Rivets, Pipes)
- Copper (Pipes, Wire)
- Oil
- Asphalt
- Cement
- Concrete (Bulk, Blocks, Pipes)
- Wood (used to manufacture dimensional lumber)

# Vehicles
- Tipper
- Tipper2
- Rubble
- Tanker
- And various trailers/box trucks

# Config
(eventually) you'll be able to set certain jobs to be only available during daylight hours.  Some servers do realistic day/night cycles, so this can be turned off.

# How to start
When you first get the job, you need to find a check-in location.  There are 4 main ones, and several other locations.  Not all locations will be listed on the map.
When you check in, you'll get your daily run sheet.  This will be the location(s) and how many load(s) each location will get, and of what material.
As for materials, you can manufacture them yourself, or purchase them off the commodities market, for a fee.  Either way, you'll be paid at the end of your shift by a set amount, as determined by pickup/drop-off location.  For example, if you Pick up a load of concrete (sand, gravel, cement, water) and deliver it to the construction site at Power St and Vespucci, the price will depend on where you delivered it from, as you can deliver concrete from either SCW Harmony (Rt 68) or SCW Senora (Senora Rd).  Since the latter is actually closer, your pay will be less.  The base price for the product is calculated as such:

Price for ((gravel + sand + cement + water) * Markup_Percentage) + (distance * per_mile_rate)

So even if you didn't manufacture the concrete yourself, the base cost of it will be calculated for you.  The price of commodities is calculated after every server restart, or once a "day" (day defined as in-game passage of time) and is based on supply, demand, and usage.
