local basiceffects = {
    stckup_handsel = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 3},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.perfect, 1), ability_table.value, colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = StackingUp.func.randvalue_default,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
            if diff ~= 0 then
				SMODS.change_play_limit(diff)
            end
        end,
        on_apply = function(card, ability_table, repeated)
            SMODS.change_play_limit(ability_table.value)
        end,
        on_remove = function(card, ability_table, card_destroyed)
            SMODS.change_play_limit(-ability_table.value)
        end,
    },
	stckup_discardsel = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 3},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.perfect, 1), ability_table.value, colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = StackingUp.func.randvalue_default,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
            if diff ~= 0 then
				SMODS.change_discard_limit(diff)
            end
        end,
        on_apply = function(card, ability_table, repeated)
            SMODS.change_discard_limit(ability_table.value)
        end,
        on_remove = function(card, ability_table, card_destroyed)
            SMODS.change_discard_limit(-ability_table.value)
        end,
    },
    stckup_consumableslot = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.perfect, 1), ability_table.value, ability_table.value == 1 and "" or "s", colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = StackingUp.func.randvalue_default,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.value
            local diff = new - old

            ability_table.value = new
            if diff ~= 0 then
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + diff
            end
        end,
        on_apply = function(card, ability_table, repeated)
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + ability_table.value
        end,
        on_remove = function(card, ability_table, card_destroyed)
			G.consumeables.config.card_limit = G.consumeables.config.card_limit - ability_table.value
        end,
    },
    stckup_handleveler = {
		type = "chain",
        ability = {value = 3, reset = 5, counter = 5, hand_type = "High Card", min_possible = 2, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.perfect, 1), localize(ability_table.hand_type, 'poker_hands'), ability_table.reset, ability_table.reset == 1 and "" or "s", ability_table.value, ability_table.value == 1 and "" or "s", ability_table.counter},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local hands = {}
			for k, hand in pairs(G.GAME.hands) do
				if hand.visible then
					hands[#hands+1] = k
				end
			end
		
			ability_table.hand_type = pseudorandom_element(hands, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
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
								level_up_hand(card, ability_table.hand_type)
								return true
							end,
						},
					}
				end
            end
        end,
    },
    stckup_hand_mult = {
		type = "passive",
        ability = {value = 10, hand_type = "High Card", min_possible = 8, max_possible = 12},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize(ability_table.hand_type, 'poker_hands')},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local hands = {}
			for k, hand in pairs(G.GAME.hands) do
				if hand.visible then
					hands[#hands+1] = k
				end
			end
		
			ability_table.hand_type = pseudorandom_element(hands, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			if ability_table.hand_type == "High Card" then
				ability_table.min_possible = 1
				ability_table.max_possible = 4
			end
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main and next(context.poker_hands[ability_table.hand_type]) then
                return {
					mult = ability_table.value
				}
            end
        end,
    },
    stckup_hand_chips = {
		type = "passive",
        ability = {value = 70, hand_type = "High Card", min_possible = 50, max_possible = 100},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize(ability_table.hand_type, 'poker_hands')},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local hands = {}
			for k, hand in pairs(G.GAME.hands) do
				if hand.visible then
					hands[#hands+1] = k
				end
			end
		
			ability_table.hand_type = pseudorandom_element(hands, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			if ability_table.hand_type == "High Card" then
				ability_table.min_possible = 10
				ability_table.max_possible = 40
			end
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main and next(context.poker_hands[ability_table.hand_type]) then
                return {
					chips = ability_table.value
				}
            end
        end,
    },
    stckup_hand_xmult = {
		type = "passive",
        ability = {value = 2, hand_type = "High Card", min_possible = 2, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, localize(ability_table.hand_type, 'poker_hands')},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local hands = {}
			for k, hand in pairs(G.GAME.hands) do
				if hand.visible then
					hands[#hands+1] = k
				end
			end
		
			ability_table.hand_type = pseudorandom_element(hands, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			if ability_table.hand_type == "High Card" then
				ability_table.min_possible = 1
				ability_table.max_possible = 1.5
			end
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main and next(context.poker_hands[ability_table.hand_type]) then
                return {
					xmult = ability_table.value
				}
            end
        end,
    },
    stckup_small_hands = {
		type = "passive",
        ability = {value = 3, target = 3, min_possible = 0, max_possible = 10},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value, ability_table.target},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local sizes = {1, 2, 3, 4}
		
			ability_table.target = pseudorandom_element(sizes, pseudoseed(card.config.center.key.."_"..ability_table.pseed))
			StackingUp.func.randvalue_tenths(card, ability_table)
			ability_table.value = ability_table.value^(1+(5-ability_table.target)/4)
			ability_table.value = math.floor(ability_table.value * 100) / 100
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
			ability_table.value = ability_table.value^(1+(5-ability_table.target)/4)
			ability_table.value = math.floor(ability_table.value * 100) / 100
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main and #context.scoring_hand <= ability_table.target then
                return {
					mult = ability_table.value
				}
            end
        end,
    },
    stckup_bj_mult = {
		type = "passive",
        ability = {value = 1.0, min_possible = 0.0, max_possible = 1.0},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				ability_table.value * (G.deck and #G.deck.cards or 52),
			},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main then
                return {
					mult = ability_table.value * #G.deck.cards
				}
            end
        end,
    },
    stckup_bj_chips = {
		type = "passive",
        ability = {value = 2.0, min_possible = 0.0, max_possible = 2.0},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				ability_table.value * (G.deck and #G.deck.cards or 52),
			},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main then
                return {
					chips = ability_table.value * #G.deck.cards
				}
            end
        end,
    },
    stckup_bj_xmult = {
		type = "passive",
        ability = {value = 0.02, min_possible = 0.01, max_possible = 0.05},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				1 + (ability_table.value * (G.deck and #G.deck.cards or 52)),
			},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main then
                return {
					xmult = 1 + (ability_table.value * #G.deck.cards)
				}
            end
        end,
    },
    stckup_more_xchips = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 1.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
			},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main then
				return {
					xchips = ability_table.value
				}
            end
        end,
    },
    stckup_combo_mult = {
		type = {"passive", "chain"},
        ability = {value = 1, min_possible = 0, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.MULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.post_trigger and context.other_card == card and context.other_ret and type(hand_chips) == "number" then
                return {
					mult = ability_table.value
				}
            end
        end,
    },
    stckup_combo_chips = {
		type = {"passive", "chain"},
        ability = {value = 1, min_possible = 0, max_possible = 10},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.CHIPS, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.post_trigger and context.other_card == card and context.other_ret and type(hand_chips) == "number" then
                return {
					chips = ability_table.value
				}
            end
        end,
    },
    stckup_combo_xmult = {
		type = {"passive", "chain"},
        ability = {value = 1, min_possible = 1, max_possible = 1.25},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.XMULT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = StackingUp.func.updvalue_default,
        calculate = function(card, context, ability_table, ability_index)
            if context.post_trigger and context.other_card == card and context.other_ret and type(hand_chips) == "number" then
                return {
					xmult = ability_table.value
				}
            end
        end,
    },
    stckup_fadeout = {
		type = "passive",
        ability = {value = 1, min_possible = 0.01, max_possible = 0.1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				G.GAME.starting_deck_size,
				ability_table.value * 100 * math.max(0, G.GAME.starting_deck_size - (G.deck and #G.playing_cards or 52))
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
            if context.joker_buff and G.GAME.starting_deck_size > #G.playing_cards then
				return {
					buff = 1 + (ability_table.value * math.max(0, G.GAME.starting_deck_size - (G.deck and #G.playing_cards or 52)))
				}
            end
        end,
    },
    stckup_enh_force = {
		type = "passive",
        ability = {value = 1, card_key = "m_wild", min_possible = 0.1, max_possible = 0.4},
        loc_vars = function(info_queue, card, ability_table)
			local enhs = 0
			if G.deck then
				for k,v in ipairs(G.playing_cards) do
					if SMODS.has_enhancement(v, ability_table.card_key) then
						enhs = enhs + 1
					end
				end
			end
			local text = localize{type = 'name_text', set = 'Enhanced', key = ability_table.card_key}
            return {vars = {
				ability_table.value * 100,
				text,
				ability_table.value * 100 * enhs
			},
			background_colour = lighten(G.C.SECONDARY_SET.Tarot, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			local enhs = {}
			if G.deck then
				for k,v in ipairs(G.playing_cards) do
					if v.config.center.set == "Enhanced" then
						enhs[#enhs+1] = v.config.center
					end
				end
			end
			if #enhs == 0 then enhs = G.P_CENTER_POOLS["Enhanced"] end
			ability_table.card_key = pseudorandom_element(enhs, ability_table.pseed.."_"..card.config.center_key).key
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_buff then
				local enhs = 0
				for k,v in ipairs(G.playing_cards) do
					if SMODS.has_enhancement(v, ability_table.card_key) then
						enhs = enhs + 1
					end
				end
				if enhs < 1 then return end
				return {
					buff = 1 + (ability_table.value * enhs)
				}
            end
        end,
    },
    stckup_hang_in_there = {
		type = "passive",
        ability = {value = 1, pos = 1, min_possible = 0, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
			local text = tostring(ability_table.pos)
			if ability_table.pos % 10 == 1 then
				text = text.."st"
			elseif ability_table.pos % 10 == 2 then
				text = text.."nd"
			else
				text = text.."th"
			end
            return {vars = {
				ability_table.value,
				ability_table.pos,
				text,
				ability_table.value == 1 and "" or "s",
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.pos = pseudorandom(ability_table.pseed.."_"..card.config.center_key, 1, G.GAME.starting_params.play_limit)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.repetition and context.scoring_hand and context.cardarea == G.play then
				for k,v in ipairs(context.scoring_hand) do
					if v == context.other_card and k == ability_table.pos then
						return {
							repetitions = ability_table.value
						}
					end
				end
            end
        end,
    },
	stckup_bigger_picture = {
		type = "passive",
        ability = {value = 1, min_possible = 0.0, max_possible = 0.1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * (G.jokers and #G.jokers.cards or 0)
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
					buff = 1 + (ability_table.value * #G.jokers.cards)
				}
            end
        end,
	},
	stckup_hardboiled = {
		type = "passive",
        ability = {value = 1, min_possible = 0, max_possible = 3},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
			},
			background_colour = lighten(G.C.MONEY, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
			if context.end_of_round and context.game_over == false and context.main_eval and ability_table.value > 0 and not context.blueprint then
				card.ability.extra_value = card.ability.extra_value + ability_table.value
				card:set_cost()
				return {
					message = localize('k_val_up'),
					colour = G.C.MONEY
				}
            end
        end,
    },
    stckup_hiking = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 10},
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
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.play then
                return {
					message = localize("k_upgrade_ex"),
					colour = G.C.CHIPS,
					func = function()
						context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + ability_table.value
					end,
				}
            end
        end,
    },
    stckup_lounging = {
		type = "passive",
        ability = {value = 1, min_possible = 1, max_possible = 5},
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
            if context.individual and not context.end_of_round and not context.repetition and context.cardarea == G.hand then
                return {
					message = localize("k_upgrade_ex"),
					colour = G.C.CHIPS,
					func = function()
						context.other_card.ability.perma_h_chips = (context.other_card.ability.perma_h_chips or 0) + ability_table.value
					end,
				}
            end
        end,
    },
	stckup_dramatic_entrance = {
		type = "passive",
        ability = {value = 1, min_possible = 0.0, max_possible = 1.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
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
            if context.joker_buff and ability_table.value > 0 and G.GAME.current_round.hands_played == 0 then
				return {
					buff = 1 + ability_table.value
				}
            end
        end,
	},
	stckup_grand_finale = {
		type = "passive",
        ability = {value = 1, min_possible = 1.0, max_possible = 2.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
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
            if context.joker_buff and ability_table.value > 0 and G.GAME.current_round.hands_left == 0 then
				return {
					buff = 1 + ability_table.value
				}
            end
        end,
	},
	stckup_critical_chance = {
		type = "passive",
        ability = {value = 3, chance = 0.15, min_possible = 2, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.chance * 100,
				ability_table.value * 100,
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
            if context.joker_buff and pseudorandom(card.config.center_key.."_"..ability_table.pseed) < ability_table.chance then
				return {
					buff = 1 + ability_table.value,
				}
            end
        end,
    },
}

return basiceffects