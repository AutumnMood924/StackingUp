local alias__Card_is_kitty = Card.is_kitty
function Card:is_kitty()
	if self.ability.hsr_extra_effects then
		for _,_effect in ipairs(self.ability.hsr_extra_effects) do
			if _effect.key == "stckup_kitty_therian" then
				return true
			end
		end
	end
	return alias__Card_is_kitty(self)
end

local vkeffects = {
    stckup_kitty_therian = {
		type = {"passive"},
        ability = { },
		no_potency = true,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = { },
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
		end,
        update_values = function(card, ability_table)
        end,
		in_pool = function(card)
			return not card:is_kitty()
		end,
    },
    stckup_kitty_force = {
		type = "passive",
        ability = {value = 1, min_possible = 0.09, max_possible = 0.99},
        loc_vars = function(info_queue, card, ability_table)
			local kitties = 0
			for k,v in ipairs(G.jokers.cards) do
				if v:is_kitty() then kitties = kitties + 1 end
			end
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * kitties,
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
				local kitties = 0
				for k,v in ipairs(G.jokers.cards) do
					if v:is_kitty() then kitties = kitties + 1 end
				end
				if kitties < 1 then return end
				return {
					buff = 1 + (ability_table.value * kitties)
				}
            end
        end,
    },
    stckup_kitty_combo = {
		type = {"passive", "chain"},
        ability = {value = 3, counter = 3, min_possible = 3, max_possible = 9},
        loc_vars = function(info_queue, card, ability_table)
			local kitties = 0
			for k,v in ipairs(G.jokers.cards) do
				if v:is_kitty() then kitties = kitties + 1 end
			end
            return {vars = {
				ability_table.value,
				ability_table.value == 1 and "" or "s",
				ability_table.counter
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_inverse(card, ability_table)
			ability_table.counter = ability_table.value
		end,
        update_values = function(card, ability_table)
            local new = (ability_table.max_possible) - ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
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
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									func = function()
										add_tag(Tag("tag_valk_kitty"))
										return true
									end
								}))
							end,
						},
					}
				end
            end
        end,
    },
}

return vkeffects