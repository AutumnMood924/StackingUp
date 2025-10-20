local zeroeffects = {
	stckup_incrementalist = {
		type = {"passive", "chain"},
        ability = {value = 6, counter = 0, card_key = "c_zero_plasmid", min_possible = 5, max_possible = 8},
        loc_vars = function(info_queue, card, ability_table)
			--info_queue[#info_queue+1] = G.P_CENTERS[ability_table.card_key]
			local text = localize{type = 'name_text', set = 'Prestige', key = ability_table.card_key}
			local text2 = text:sub(1,1):upper()
			local text3 = ""
			if text2 == "A" or text2 == "E" or text2 == "I" or text2 == "O" or text2 == "U" then
				text3 = "n"
			end
            return {vars = {
				text, text3,
				ability_table.value,
				math.max(0,ability_table.value - ability_table.counter),
			},
			background_colour = lighten(G.C.SECONDARY_SET.Prestige, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.card_key = pseudorandom_element(G.P_CENTER_POOLS["Prestige"], ability_table.pseed.."_"..card.config.center_key).key
			StackingUp.func.randvalue_inverse(card, ability_table)
			ability_table.value = math.max(1,ability_table.value)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_inverse(card, ability_table)
			ability_table.value = math.max(1,ability_table.value)
		end,
		calculate = function(card, context, ability_table, ability_index)
			if context.post_trigger and context.other_card == card and context.other_ret then
				ability_table.counter = ability_table.counter + 1
				if ability_table.counter >= ability_table.value and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					--card:juice_up(0.3, 0.5)
					ability_table.counter = 0
					
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = (function()
							G.E_MANAGER:add_event(Event({
								func = function() 
									local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, ability_table.card_key, ability_table.pseed.."_"..card.config.center_key)
									card:add_to_deck()
									G.consumeables:emplace(card)
									G.GAME.consumeable_buffer = 0
									return true
								end}))   
								card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'yippee', colour = G.C.GOLD})
							return true
						end)}))
				end
			end
		end,
	},
}

return zeroeffects