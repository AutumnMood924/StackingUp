local ammeffects = {
    stckup_suitleveler = {
		type = "chain",
        ability = {value = 2, reset = 4, counter = 4, suit = "Hearts", min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.perfect, 1), localize(ability_table.suit, 'suits_plural'), ability_table.reset, ability_table.reset == 1 and "" or "s", ability_table.value, ability_table.value == 1 and "" or "s", ability_table.counter, colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}, G.C.SUITS[ability_table.suit]}},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local suits = {}
			for i = #SMODS.Suit.obj_buffer, 1, -1 do
				local suit = SMODS.Suit.obj_buffer[i]
				if not SMODS.Suits[suit].in_pool or SMODS.Suits[suit]:in_pool{rank=""} then
					suits[#suits+1] = suit
				end
			end
		
			ability_table.suit = pseudorandom_element(suits, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_inverse(card, ability_table)
			ability_table.value = math.max(0,ability_table.value)
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
					ability_table.reset = ability_table.reset + ability_table.value
					ability_table.counter = ability_table.reset
					
					return {
						extra = {
							func = function()
								AMM.level_up_suit(card, ability_table.suit, nil, 1)
								return true
							end,
						},
					}
				end
            end
        end,
    },
	stckup_cq_mult = {
		type = "attack",
        ability = {value = 6, quality = "face", min_possible = 2, max_possible = 8},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.play and AMM.api.cardqualities.has(context.other_card, ability_table.quality) then
                return {
					mult = ability_table.value
				}
            end
        end,
    },
    stckup_cq_chips = {
		type = "attack",
        ability = {value = 30, quality = "face", min_possible = 15, max_possible = 45},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.play and AMM.api.cardqualities.has(context.other_card, ability_table.quality) then
                return {
					chips = ability_table.value
				}
            end
        end,
    },
    stckup_cq_xmult = {
		type = "attack",
        ability = {value = 1, quality = "face", min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.play and AMM.api.cardqualities.has(context.other_card, ability_table.quality) then
                return {
					xmult = ability_table.value
				}
            end
        end,
    },
    stckup_first_cq_mult = {
		type = "attack",
        ability = {value = 10, quality = "face", min_possible = 4, max_possible = 15},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.play and AMM.api.cardqualities.has(context.other_card, ability_table.quality) then
				local first_cq = false
				for i = 1, #context.scoring_hand do
					if AMM.api.cardqualities.has(context.scoring_hand[i], ability_table.quality) then
						first_cq = context.scoring_hand[i] == context.other_card
						break
					end
				end
				if first_cq then
					return {
						mult = ability_table.value
					}
				end
            end
        end,
    },
    stckup_first_cq_chips = {
		type = "attack",
        ability = {value = 50, quality = "face", min_possible = 30, max_possible = 50},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.play and AMM.api.cardqualities.has(context.other_card, ability_table.quality) then
				local first_cq = false
				for i = 1, #context.scoring_hand do
					if AMM.api.cardqualities.has(context.scoring_hand[i], ability_table.quality) then
						first_cq = context.scoring_hand[i] == context.other_card
						break
					end
				end
				if first_cq then
					return {
						chips = ability_table.value
					}
				end
            end
        end,
    },
    stckup_first_cq_xmult = {
		type = "attack",
        ability = {value = 2, quality = "face", min_possible = 1, max_possible = 1.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value, ability_table.quality)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.play and AMM.api.cardqualities.has(context.other_card, ability_table.quality) then
				local first_cq = false
				for i = 1, #context.scoring_hand do
					if AMM.api.cardqualities.has(context.scoring_hand[i], ability_table.quality) then
						first_cq = context.scoring_hand[i] == context.other_card
						break
					end
				end
				if first_cq then
					return {
						xmult = ability_table.value
					}
				end
            end
        end,
    },
	stckup_skulking = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 15},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
			},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == "unscored" then
                return {
					message = localize("k_upgrade_ex"),
					colour = G.C.CHIPS,
					func = function()
						context.other_card.ability.perma_u_chips = (context.other_card.ability.perma_u_chips or 0) + ability_table.value
					end,
				}
            end
        end,
    },
    stckup_cq_force = {
		type = "passive",
        ability = {value = 1, quality = "face", min_possible = 0.01, max_possible = 0.03},
        loc_vars = function(info_queue, card, ability_table)
			local cqs = 0
			if G.deck then
				for k,v in ipairs(G.playing_cards) do
					if AMM.api.cardqualities.has(v, ability_table.quality) then
						cqs = cqs + 1
					end
				end
			end
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * cqs,
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.SECONDARY_SET.Tarot, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_hundreths(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value*10, ability_table.quality)/10
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = StackingUp.func.cardquality_value(ability_table.value*10, ability_table.quality)/10
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_buff then
				local cqs = 0
				for k,v in ipairs(G.playing_cards) do
					if AMM.api.cardqualities.has(v, ability_table.quality) then
						cqs = cqs + 1
					end
				end
				if cqs < 1 then return end
				return {
					buff = 1 + (ability_table.value * cqs)
				}
            end
        end,
    },
    stckup_cq_spawner = {
		type = "passive",
        ability = {value = 1, quality = "face", min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				ability_table.value == 1 and "" or "s",
				AMM.api.cardqualities.localize(ability_table.quality),
				AMM.api.cardqualities.localize(ability_table.quality,1)
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.quality = AMM.api.cardqualities.random(pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
			if context.first_hand_drawn and not context.blueprint then
				local _cards = AMM.api.cardqualities.create(ability_table.quality, ability_table.value, G.hand, card.config.center_key.."_"..ability_table.pseed)

				
				G.E_MANAGER:add_event(Event({
					func = function()
						for k,_card in ipairs(_cards) do
							G.GAME.blind:debuff_card(_card)
						end
						G.hand:sort()
						card:juice_up()
						SMODS.calculate_context({ playing_card_added = true, cards = _cards })
						save_run()
						return true
					end
				}))
            end
        end,
    },
    stckup_grave_force = {
		type = "passive",
        ability = {value = 1, min_possible = 0.01, max_possible = 0.10},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = { key = "graveyard", set = "Other" }
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * AMM.api.graveyard.count_cards(),
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
				return {
					buff = 1 + (ability_table.value * AMM.api.graveyard.count_cards())
				}
            end
        end,
    },
}

return ammeffects