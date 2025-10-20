local pkmneffects = {
    stckup_poketype_mult = {
		type = {"passive", "aura"},
        ability = {value = 2, type = "Colorless", min_possible = 3, max_possible = 12},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("poke_" .. ability_table.type:lower() .. "_badge"), colours = {G.ARGS.LOC_COLOURS[ability_table.type:lower()]}},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local types = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Dark", "Metal", "Fairy", "Dragon", "Earth"}
			-- Bird is intentionally omitted
		
			ability_table.type = pseudorandom_element(types, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and is_type(context.other_joker, ability_table.type) then
				return {
					mult = ability_table.value
				}
            end
        end,
    },
    stckup_poketype_chips = {
		type = {"passive", "aura"},
        ability = {value = 66, type = "Colorless", min_possible = 8, max_possible = 60},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("poke_" .. ability_table.type:lower() .. "_badge"), colours = {G.ARGS.LOC_COLOURS[ability_table.type:lower()]}},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local types = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Dark", "Metal", "Fairy", "Dragon", "Earth"}
			-- Bird is intentionally omitted
		
			ability_table.type = pseudorandom_element(types, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and is_type(context.other_joker, ability_table.type) then
				return {
					chips = ability_table.value
				}
            end
        end,
    },
    stckup_poketype_xmult = {
		type = {"passive", "aura"},
        ability = {value = 1.4, type = "Colorless", min_possible = 1.0, max_possible = 1.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize("poke_" .. ability_table.type:lower() .. "_badge"), colours = {G.ARGS.LOC_COLOURS[ability_table.type:lower()]}},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local types = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Dark", "Metal", "Fairy", "Dragon", "Earth"}
			-- Bird is intentionally omitted
		
			ability_table.type = pseudorandom_element(types, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.other_joker and is_type(context.other_joker, ability_table.type) then
				return {
					xmult = ability_table.value
				}
            end
        end,
    },
    stckup_hazard_setter = {
		type = {"passive", "cursed"},
        ability = {value = 2, min_possible = 2, max_possible = 5},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {ability_table.value}}
			info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.setting_blind then
				poke_set_hazards(ability_table.value)
            end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
    },
    stckup_spikes = {
		type = {"attack", "cursed"},
        ability = {value = 4, min_possible = 4, max_possible = 13},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {3}}
			info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.setting_blind then
				poke_set_hazards(3)
            end
			if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") and not context.end_of_round then
				return { mult = ability_table.value }
			end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
    },
    stckup_tspikes = {
		type = {"attack", "cursed"},
        ability = {value = 0.05, min_possible = 0.04, max_possible = 0.13},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {2}}
			info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
            return {vars = {ability_table.value * 100},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.setting_blind then
				poke_set_hazards(2)
            end
			if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") and not context.end_of_round then
				return { func = function()
					G.GAME.blind.chips = G.GAME.blind.chips - (G.GAME.blind.chips * ability_table.value)
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
					context.other_card:juice_up()
				end }
			end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
    },
    stckup_stealth_rock = {
		type = {"attack", "cursed"},
        ability = {value = 2, min_possible = 1.5, max_possible = 3.0},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {1}}
			info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.setting_blind then
				poke_set_hazards(1)
            end
			if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_poke_hazard") and not context.end_of_round then
				return { xchips = ability_table.value }
			end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
    },
    stckup_future_sight = {
		type = {"passive"},
        ability = {value = 1, min_possible = 2, max_possible = 5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			local oldval = ability_table.value
			StackingUp.func.updvalue_whole(card, ability_table)
			if oldval and ability_table.value ~= oldval then
				local diff = ability_table.value - oldval
				G.GAME.scry_amount = (G.GAME.scry_amount or 0) + diff
			end
        end,
        on_apply = function(card, ability_table, repeated)
			G.GAME.scry_amount = (G.GAME.scry_amount or 0) + ability_table.value
        end,
        on_remove = function(card, ability_table, card_destroyed)
			G.GAME.scry_amount = math.max(0, (G.GAME.scry_amount or 0) - ability_table.value)
        end,
    },
}

return pkmneffects