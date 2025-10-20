local rbeffects = {
    stckup_loyalty_gain = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 3},
        loc_vars = function(info_queue, card, ability_table)
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
			if context.end_of_round and context.game_over == false and context.main_eval and ability_table.value > 0 and not context.blueprint and card.config.center.planeswalker then
				card.ability.extra.loyalty = card.ability.extra.loyalty + ability_table.value
				return {
					message = "+"..ability_table.value.." Loyalty",
					--colour = G.C.MONEY
				}
            end
        end,
		in_pool = function(card)
			return card.config.center.planeswalker
		end,
    },
    stckup_loyalty_haste = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, ability_table.value == 1 and "" or "s"},
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
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						--print(card.ability.extra.uses)
						card.ability.extra.uses = card.ability.extra.uses + ability_table.value
						return true
					end
				}))
            end
        end,
		in_pool = function(card)
			return card.config.center.default_loyalty_effects
		end,
    },
}

return rbeffects