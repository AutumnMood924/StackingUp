local alias__JoyousSpring_is_monster_type = JoyousSpring.is_monster_type
function JoyousSpring.is_monster_type(card, monster_type)
	if JoyousSpring.is_monster_card(card) and card.ability.hsr_extra_effects then
		for k,v in ipairs(card.ability.hsr_extra_effects) do
			if v.key == "stckup_bonus_ygotype" and v.ability.type == monster_type then
				return true
			end
		end
	end
	return alias__JoyousSpring_is_monster_type(card, monster_type)
end
local alias__JoyousSpring_is_attribute = JoyousSpring.is_attribute
function JoyousSpring.is_attribute(card, attribute)
	if JoyousSpring.is_monster_card(card) and card.ability.hsr_extra_effects then
		for k,v in ipairs(card.ability.hsr_extra_effects) do
			if v.key == "stckup_bonus_attr" and v.ability.attr == attribute then
				return true
			end
		end
	end
	return alias__JoyousSpring_is_attribute(card, attribute)
end

local ygoeffects = {
    stckup_attr_mult = {
		type = {"passive", "aura"},
        ability = {value = 2, attr = "DARK", min_possible = 3, max_possible = 12},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("k_joy_" .. ability_table.attr), colours = {G.C.JOY[ability_table.attr]}},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local attrs = {"LIGHT", "FIRE", "WATER", "EARTH", "DARK", "WIND"}
			-- DIVINE is intentionally omitted
		
			ability_table.attr = pseudorandom_element(attrs, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and JoyousSpring.is_attribute(context.other_joker, ability_table.attr) then
				return {
					mult = ability_table.value
				}
            end
        end,
    },
    stckup_attr_chips = {
		type = {"passive", "aura"},
        ability = {value = 50, attr = "DARK", min_possible = 8, max_possible = 80,},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("k_joy_" .. ability_table.attr), colours = {G.C.JOY[ability_table.attr]}},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local attrs = {"LIGHT", "FIRE", "WATER", "EARTH", "DARK", "WIND"}
			-- DIVINE is intentionally omitted
		
			ability_table.attr = pseudorandom_element(attrs, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and JoyousSpring.is_attribute(context.other_joker, ability_table.attr) then
				return {
					chips = ability_table.value
				}
            end
        end,
    },
    stckup_attr_xmult = {
		type = {"passive", "aura"},
        ability = {value = 1.5, attr = "DARK", min_possible = 1.0, max_possible = 2.0},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("k_joy_" .. ability_table.attr), colours = {G.C.JOY[ability_table.attr]}},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local attrs = {"LIGHT", "FIRE", "WATER", "EARTH", "DARK", "WIND"}
			-- DIVINE is intentionally omitted
		
			ability_table.attr = pseudorandom_element(attrs, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and JoyousSpring.is_attribute(context.other_joker, ability_table.attr) then
				return {
					xmult = ability_table.value
				}
            end
        end,
    },
    stckup_ygotype_mult = {
		type = {"passive", "aura"},
        ability = {value = 10, type = "Fiend", min_possible = 4, max_possible = 16},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("k_joy_" .. ability_table.type)},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local types = {"Aqua", "Beast", "BeastWarrior", "Cyberse", "Dinosaur", "Dragon", "Fairy", "Fiend", "Fish", "Illusion", "Insect", "Machine", "Plant", "Psychic", "Pyro", "Reptile", "Rock", "SeaSerpent", "Spellcaster", "Thunder", "Warrior", "WingedBeast", "Wyrm", "Zombie"}
			-- DivineBeast and CreatorGod are intentionally omitted
		
			ability_table.type = pseudorandom_element(types, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and JoyousSpring.is_monster_type(context.other_joker, ability_table.type) then
				return {
					mult = ability_table.value
				}
            end
        end,
    },
    stckup_ygotype_chips = {
		type = {"passive", "aura"},
        ability = {value = 50, type = "Fiend", min_possible = 25, max_possible = 150},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("k_joy_" .. ability_table.type)},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local types = {"Aqua", "Beast", "BeastWarrior", "Cyberse", "Dinosaur", "Dragon", "Fairy", "Fiend", "Fish", "Illusion", "Insect", "Machine", "Plant", "Psychic", "Pyro", "Reptile", "Rock", "SeaSerpent", "Spellcaster", "Thunder", "Warrior", "WingedBeast", "Wyrm", "Zombie"}
			-- DivineBeast and CreatorGod are intentionally omitted
		
			ability_table.type = pseudorandom_element(types, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and JoyousSpring.is_monster_type(context.other_joker, ability_table.type) then
				return {
					chips = ability_table.value
				}
            end
        end,
    },
    stckup_ygotype_xmult = {
		type = {"passive", "aura"},
        ability = {value = 1.5, type = "Fiend", min_possible = 1.5, max_possible = 2.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("k_joy_" .. ability_table.type)},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local types = {"Aqua", "Beast", "BeastWarrior", "Cyberse", "Dinosaur", "Dragon", "Fairy", "Fiend", "Fish", "Illusion", "Insect", "Machine", "Plant", "Psychic", "Pyro", "Reptile", "Rock", "SeaSerpent", "Spellcaster", "Thunder", "Warrior", "WingedBeast", "Wyrm", "Zombie"}
			-- DivineBeast and CreatorGod are intentionally omitted
		
			ability_table.type = pseudorandom_element(types, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and JoyousSpring.is_monster_type(context.other_joker, ability_table.type) then
				return {
					xmult = ability_table.value
				}
            end
        end,
    },
	stckup_bonus_attr = {
		type = "passive",
		no_potency = true,
		ability = {attr = "DIVINE"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("k_joy_" .. ability_table.attr), colours = {G.C.JOY[ability_table.attr]}},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local attrs = {"LIGHT", "FIRE", "WATER", "EARTH", "DARK", "WIND"}
			-- DIVINE is intentionally omitted
			
			local newattrs = {}
			for _,att in ipairs(attrs) do
				if not JoyousSpring.is_attribute(card, att) then
					newattrs[#newattrs+1] = att
				end
			end
			if #newattrs == 0 then newattrs[#newattrs+1] = "DIVINE" end
		
			ability_table.attr = pseudorandom_element(newattrs, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
		end,
		in_pool = function(card)
			return JoyousSpring.is_monster_card(card) and not JoyousSpring.is_all_attributes(card)
		end,
	},
	stckup_bonus_ygotype = {
		type = "passive",
		no_potency = true,
		ability = {ygotype = "DivineBeast"},
        loc_vars = function(info_queue, card, ability_table)
			local text = localize("k_joy_" .. ability_table.type)
			local text2 = text:sub(1,1):upper()
			local text3 = ""
			if text2 == "A" or text2 == "E" or text2 == "I" or text2 == "O" or text2 == "U" then
				text3 = "n"
			end
            return {vars = {text, text3},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local types = {"Aqua", "Beast", "BeastWarrior", "Cyberse", "Dinosaur", "Dragon", "Fairy", "Fiend", "Fish", "Illusion", "Insect", "Machine", "Plant", "Psychic", "Pyro", "Reptile", "Rock", "SeaSerpent", "Spellcaster", "Thunder", "Warrior", "WingedBeast", "Wyrm", "Zombie"}
			-- DivineBeast and CreatorGod are intentionally omitted
			
			local newtypes = {}
			for _,typ in ipairs(types) do
				if not JoyousSpring.is_monster_type(card, typ) then
					newtypes[#newtypes+1] = typ
				end
			end
			if #newtypes == 0 then newtypes[#newtypes+1] = "DivineBeast" end
		
			ability_table.type = pseudorandom_element(newtypes, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
		end,
		in_pool = function(card)
			return JoyousSpring.is_monster_card(card) and not JoyousSpring.is_all_types(card)
		end,
	},
	stckup_phasing = {
		type = {"passive", "cursed"},
        ability = { mode = 0 },
		no_potency = true,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
		end,
        update_values = function(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.setting_blind then
				if ability_table.mode == 0 then
					ability_table.mode = 1
					JoyousSpring.banish(card, "blind_selected", nil, nil)
				else
					ability_table.mode = 0
				end
            end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
	},
	stckup_hypervisor = {
		type = "passive",
		no_potency = true,
		ability = {},
        loc_vars = function(info_queue, card, ability_table)
			return {vars = { },
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
	},
}

return ygoeffects