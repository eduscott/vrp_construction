--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]


local cfg = {}

cfg.crops= {
  ["apple"] = {
    name = "Apple",
    desc = "A succulent red apple.",
    price = 5,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.10
  },
  ["flower"] = {
    name = "Flowers",
    desc = "A handful of sweet smelling flowers.",
    price = 3,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.10
  },
  ["corn"] = {
    name = "Corn",
    desc = "An ear of corn.",
    price = 3,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.10
  },
  ["sugar"] = {
    name = "Sugar",
    desc = "Some sugar.",
    price = 5,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.10
  },
  ["bmilk"] = {
    name = "Bucket of Milk",
    desc = "A bucket of Milk.",
    price = 4,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.20
  },
  ["wheat"] = {
    name = "Wheat",
    desc = "A bushel of wheat.",
    price = 3,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.20
  },
  ["beef"] = {
    name = "Beef",
    desc = "A slab of red meat. Moo.",
    price = 8,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.50
  },
  ["chicken"] = {
    name = "Chicken",
    desc = "A whole chicken. Bwak.",
    price = 6,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.40
  },
  ["eggs"] = {
    name = "Eggs",
    desc = "Unhatched little chickens. Chirp.",
    price = 3,
    choices = function(args)
    local menu = {}
    return menu
    end,
  weight = 0.10
  }
}

return cfg