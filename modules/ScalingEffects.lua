local scalingeffects = {
	stckup_simple_scaling = {
		type = "scaling",
		ability = {value = 1, min_possible = 0, max_possible = 10},
		loc_vars = function(info_queue, card, ability_table)
			return {vars = {
				ability_table.value,
			},
			background_colour = lighten(G.C.SECONDARY_SET.Spectral, StackingUp.bg_contrast)}
		end,
		randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
		update_values = function(card, ability_table)
			StackingUp.func.updvalue_tenths(card, ability_table)
		end,
		calculate = function(card, context, ability_table, ability_index)
			if context.end_of_round and context.game_over == false and context.main_eval and ability_table.value > 0 and not context.blueprint then
				StackingUp.func.scalingeffect{
					card = card,
					mode = "random",
					pseed = card.config.center_key.."_"..ability_table.pseed,
					amount = ability_table.value
				}
				return {
					message = localize('k_val_up'),
					colour = G.C.GREEN
				}
			end
		end,
		in_pool = function(card)
			return card.ability.hsr_extra_effects and #card.ability.hsr_extra_effects > 0
		end,
	},
	stckup_caino = {
		type = "scaling",
		ability = {value = 1, quality = "face", min_possible = 5, max_possible = 10},
		loc_vars = function(info_queue, card, ability_table)
			local text = AMM.api.cardqualities.localize(ability_table.quality)
			local text2 = text:sub(1,1):upper()
			local text3 = ""
			if text2 == "A" or text2 == "E" or text2 == "I" or text2 == "O" or text2 == "U" then
				text3 = "n"
			end
			return {vars = {
				ability_table.value,
				text,
				AMM.api.cardqualities.localize(ability_table.quality,1),
				text3,
			},
			background_colour = lighten(G.C.RARITY[4], StackingUp.bg_contrast)}
		end,
		randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
			ability_table.value = Stacked.round(ability_table.value, 1)
		end,
		update_values = function(card, ability_table)
			StackingUp.func.updvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
			ability_table.value = Stacked.round(ability_table.value, 1)
		end,
		calculate = function(card, context, ability_table, ability_index)
			if context.remove_playing_cards and ability_table.value > 0 and not context.blueprint then
				local cq_cards = 0
				for _, removed_card in ipairs(context.removed) do
					if AMM.api.cardqualities.has(removed_card, ability_table.quality) then cq_cards = cq_cards + 1 end
				end
				if cq_cards > 0 then
					StackingUp.func.scalingeffect{
						card = card,
						--mode = "random",
						pseed = card.config.center_key.."_"..ability_table.pseed,
						amount = ability_table.value
					}
					return {
						message = localize('k_val_up'),
						colour = G.C.GREEN
					}
				end
			end
		end,
		in_pool = function(card)
			return card.ability.hsr_extra_effects and #card.ability.hsr_extra_effects > 0
		end,
	},
	stckup_yorick = {
		type = "scaling",
		ability = {value = 1, threshold = 23, remaining = 23, min_possible = 5, max_possible = 20},
		loc_vars = function(info_queue, card, ability_table)
			return {vars = {
				ability_table.value,
				ability_table.threshold,
				ability_table.remaining,
			},
			background_colour = lighten(G.C.RARITY[4], StackingUp.bg_contrast)}
		end,
		randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
		update_values = function(card, ability_table)
			StackingUp.func.updvalue_tenths(card, ability_table)
		end,
		calculate = function(card, context, ability_table, ability_index)
			if context.discard and not context.blueprint then
				if ability_table.remaining <= 1 then
					ability_table.remaining = ability_table.threshold
					StackingUp.func.scalingeffect{
						card = card,
						--mode = "random",
						pseed = card.config.center_key.."_"..ability_table.pseed,
						amount = ability_table.value
					}
					return {
						message = localize('k_val_up'),
						colour = G.C.GREEN
					}
				else
					ability_table.remaining = ability_table.remaining - 1
					return nil, true -- something something retriggers?
					-- maybe investigate why this matters TODO
				end
			end
		end,
		in_pool = function(card)
			return card.ability.hsr_extra_effects and #card.ability.hsr_extra_effects > 0
		end,
	},
}

return scalingeffects