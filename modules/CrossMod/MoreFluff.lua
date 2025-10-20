local mfeffects = {
    stckup_colour_by_jokes = {
		type = "chain",
        ability = {value = 4, counter = 4, min_possible = 2, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				ability_table.value == 1 and "" or "s",
				ability_table.counter
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_inverse(card, ability_table)
			ability_table.value = math.max(0,ability_table.value)
			ability_table.counter = ability_table.value
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_inverse(card, ability_table)
			ability_table.value = math.max(0,ability_table.value)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.post_trigger and context.other_card == card and context.other_ret then
                ability_table.counter = ability_table.counter - 1
				if ability_table.counter <= 0 then
					ability_table.counter = ability_table.value
					
					return {
						extra = {
							func = function()
								colour_end_of_round_effects()
								return true
							end,
						},
					}
				end
            end
        end,
    },
}

return mfeffects