local gbeffects = {
	stckup_hexing_jesting = {
		type = {"passive", "cursed"},
        ability = {value = 0.01, hex_key = "slothful", min_possible = 0.03, max_possible = 0.13},
        loc_vars = function(info_queue, card, ability_table)
			local hexxies = 0
			for k,v in ipairs(G.playing_cards) do
				if GB.get_hex(v) then
					hexxies = hexxies + 1
				end
			end
			info_queue[#info_queue+1] = GB.hex_tooltip(ability_table.hex_key)
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * hexxies,
				localize{type = 'name_text', set = 'Other', key = "gb_"..ability_table.hex_key.."_hex"},
				colours = {HEX("9493aa")}
			},
			background_colour = lighten(G.C.SECONDARY_SET.Tarot, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.hex_key = pseudorandom_element(GB.HEX_KEYS, card.config.center_key.."_"..ability_table.pseed)
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_buff and ability_table.value > 0 then
				local hexxies = 0
				for k,v in ipairs(G.playing_cards) do
					if GB.get_hex(v) then
						hexxies = hexxies + 1
					end
				end
				if hexxies == 0 then return end
				return {
					buff = 1 + (ability_table.value * hexxies)
				}
            end
			if context.end_of_round and context.game_over == false and context.main_eval and ability_table.value > 0 and not context.blueprint then
				--[[card.ability.extra_value = card.ability.extra_value + ability_table.value
				card:set_cost()--]]
				gb_apply_hex(G.playing_cards, ability_table.hex_key, 1)
				return {
					message = "Hexed!",--localize('k_val_up'),
					colour = G.C.SECONDARY_SET.Hex
				}
            end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
	},
    stckup_mist_force = {
		type = "passive",
        ability = {value = 1, min_possible = 0.05, max_possible = 0.20},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * G.GAME.consumeable_usage_total.ephemeral,
			},
			background_colour = lighten(G.C.SECONDARY_SET.Tarot, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_buff then
				if G.GAME.consumeable_usage_total.ephemeral < 1 then return end
				return {
					buff = 1 + (ability_table.value * G.GAME.consumeable_usage_total.ephemeral)
				}
            end
        end,
    },
}

return zeroeffects