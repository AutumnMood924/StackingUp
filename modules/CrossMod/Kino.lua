if next(SMODS.find_mod("kino")) then
	local alias__Kino_count_bullets = Kino.count_bullets
	function Kino:count_bullets()
		local _bullet_count = alias__Kino_count_bullets(self)
		for __,_joker in ipairs(G.jokers.cards) do
			if _joker.ability.hsr_extra_effects then
				for _,_effect in ipairs(_joker.ability.hsr_extra_effects) do
					if _effect.key == "stckup_magazine" then
						_bullet_count = _bullet_count + _effect.ability.value
					end
				end
			end
		end
		return _bullet_count
	end
end

local kinomode = next(SMODS.find_mod("kino"))
local countermode = next(SMODS.find_mod("Blockbuster-Counters"))
local spellcastmode = next(SMODS.find_mod("Blockbuster-Spellcasting"))

local kinoeffects = {
	stckup_magazine = kinomode and {
		type = "passive",
        ability = {value = 1, min_possible = 0, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				ability_table.value == 1 and "" or "s",
			},
			background_colour = lighten(G.C.SECONDARY_SET.Planet, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
    },
	stckup_spellcaster = spellcastmode and {
		type = "passive",
        ability = {value = 1, min_possible = 2, max_possible = 14},
        loc_vars = function(info_queue, card, ability_table)
			local tbl = {
				"nil",
				"2", "3", "4", "5", "6", "7", "8", "9", "10",
				"Jack", "Queen", "King", "Ace"
			}
			local text = localize(tbl[math.max(2,math.min(14,ability_table.value))], 'ranks')
			local text2 = text:sub(1,1):upper()
			local text3 = ""
			if text2 == "A" or text2 == "E" or text2 == "I" or text2 == "O" or text2 == "U" then
				text3 = "n"
			end
            return {vars = {
				text, text3
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
		calculate = function(card, context, ability_table, ability_index)
			if context.joker_main and #G.hand.cards > 1 then
				local _strength = Blockbuster.id_to_spell_level(ability_table.value)
				local _spell_key = Blockbuster.cards_to_spell_key(G.hand.cards)
				local _return_table = Blockbuster.cast_spell(_spell_key, _strength)
				G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
					attention_text({
						text = localize({type="name_text", set="Spell", key= _spell_key }),
						scale = 1.3, 
						hold = 1.4,
						major = G.play,
						align = 'tm',
						offset = {x = 0, y = -1},
						silent = true
					})
					card:juice_up()
				return true end }))

				if type(_return_table) ~= 'table' then return nil end
				card_eval_status_text(card, 'extra', nil, nil, nil,
				{ message = localize('k_spell_cast'), colour = G.C.PURPLE })
				return _return_table
			end
		end,
	},
    stckup_genre_whiplash = kinomode and {
		type = "passive",
        ability = {value = 1, min_possible = 0, max_possible = 0.3},
        loc_vars = function(info_queue, card, ability_table)
			local genres = {}
			if not card.area.config.collection then
				for k,v in ipairs(G.jokers.cards) do
					local _genres = v and v.config.center.k_genre or {}
					if #_genres >= 1 then
						for i, _genre in ipairs(_genres) do
							genres[_genre] = 1
						end
					end
				end
			end
			local uniques = 0
			for k,v in pairs(genres) do uniques = uniques + 1 end
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * uniques
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
				local genres = {}
				for k,v in ipairs(G.jokers.cards) do
					local _genres = v and v.config.center.k_genre or {}
					if #_genres >= 1 then
						for i, _genre in ipairs(_genres) do
							genres[_genre] = 1
						end
					end 
				end
				local uniques = 0
				for k,v in pairs(genres) do uniques = uniques + 1 end
				if uniques == 0 then return end
				return {
					buff = 1 + (ability_table.value * uniques)
				}
            end
        end,
    },
    stckup_more_dakka = kinomode and {
		type = "passive",
        ability = {value = 1, min_possible = 0, max_possible = 0.5},
        loc_vars = function(info_queue, card, ability_table)
			local bullets = Kino.count_bullets()
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * bullets
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
				local bullets = Kino.count_bullets()
				if bullets < 1 then return end
				return {
					buff = 1 + (ability_table.value * bullets)
				}
            end
        end,
    },
	stckup_genre_hater = kinomode and {
		type = "passive",
        ability = {value = 1, genre = "War", min_possible = 0.1, max_possible = 0.4},
        loc_vars = function(info_queue, card, ability_table)
			local nonhated = 0
			if not card.area.config.collection then
				for k,v in ipairs(G.jokers.cards) do
					local _genres = v and v.config.center.k_genre or {}
					if #_genres >= 1 then
						local doit = true
						for i, _genre in ipairs(_genres) do
							if _genre == ability_table.genre then
								doit = false
							end
						end
						if doit then nonhated = nonhated + 1 end
					end
				end
			end
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * nonhated,
				ability_table.genre,
				colours = {G.ARGS.LOC_COLOURS[ability_table.genre]}
			},
			background_colour = lighten(G.C.SECONDARY_SET.Tarot, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.genre = pseudorandom_element(kino_genres, ability_table.pseed.."_"..card.config.center_key)
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_buff then
				local nonhated = 0
				for k,v in ipairs(G.jokers.cards) do
					local _genres = v and v.config.center.k_genre or {}
					if #_genres >= 1 then
						local doit = true
						for i, _genre in ipairs(_genres) do
							if _genre == ability_table.genre then
								doit = false
							end
						end
						if doit then nonhated = nonhated + 1 end
					end
				end
				if nonhated == 0 then return end
				return {
					buff = 1 + (ability_table.value * nonhated)
				}
            end
        end,
	},
	stckup_conflagration = countermode and {
		type = {"attack", "cursed"},
        ability = {value = 1.75, min_possible = 1.5, max_possible = 3},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = Blockbuster.Counters.Counters["counter_burn"]
            return {vars = {
				ability_table.value,
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
            if ability_table.value > 0 then
				local doit = false
				if context.individual and context.cardarea == G.play and context.other_card.counter and context.other_card.counter.key == "counter_burn" then
					doit = true
				end
				if context.other_joker and context.other_joker.counter and context.other_joker.counter.key == "counter_burn" then
					doit = true
				end
				if doit then return { xmult = ability_table.value } end
            end
			if context.after and #G.hand.cards > 0 and not context.blueprint then
				local _target = pseudorandom_element(G.hand.cards, card.config.center_key.."_"..ability_table.pseed)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
					card:juice_up()
					return true end
				}))
				_target:bb_counter_apply("counter_burn", 1)
            end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
	},
	stckup_truant = countermode and {
		type = {"chain", "cursed"},
        ability = { },
		no_potency = true,
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = Blockbuster.Counters.Counters["counter_stun"]
            return {vars = {
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
		end,
        update_values = function(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.post_trigger and context.other_card == card and context.other_ret then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.00, func = function()
					if not card.counter or (card.counter.key ~= "counter_stun") then
						card:bb_counter_apply("counter_stun", 1)
					end
					return true end
				}))
			end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
	},
	stckup_counter_up = countermode and {
		type = {"passive"},
        ability = {value = 1, min_possible = 1, max_possible = 3},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
			if card.counter and context.end_of_round and context.game_over == false and context.main_eval and ability_table.value > 0 and not context.blueprint then
				card:bb_increment_counter(ability_table.value, nil)
            end
        end,
	},
	stckup_held_counter = countermode and {
		type = {"passive"},
        ability = {value = 1, counter = "counter_mult", min_possible = 2, max_possible = 5},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = Blockbuster.Counters.Counters[ability_table.counter]
            return {vars = {
				ability_table.value,
				localize{type = 'name_text', set = 'Counter', key = ability_table.counter},
				ability_table.value == 1 and "" or "s",
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.counter = pseudorandom_element({
				"counter_mult", "counter_chip", "counter_xmult",
				"counter_retrigger", "counter_money"
			}, card.config.center_key.."_"..ability_table.pseed)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
			if context.end_of_round and context.game_over == false and context.main_eval and ability_table.value > 0 and not context.blueprint then
				for i=1,ability_table.value do
					local _target = pseudorandom_element(G.hand.cards, card.config.center_key.."_"..ability_table.pseed)
					_target:bb_counter_apply(ability_table.counter, 1, nil)
				end
				return {
					message = "Counters!",
				}
            end
        end,
	},
    stckup_counter_force = countermode and {
		type = "passive",
        ability = {value = 1, counter = "counter_mult", min_possible = 0.03, max_possible = 0.06},
        loc_vars = function(info_queue, card, ability_table)
			local counters = 0
			if G.deck then
				for k,v in ipairs(G.playing_cards) do
					if Blockbuster.Counters.is_counter(v, ability_table.counter) then
						counters = counters + Blockbuster.Counters.get_counter_num(v)
					end
				end
			end
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * counters,
				localize{type = 'name_text', set = 'Counter', key = ability_table.counter},
			},
			background_colour = lighten(G.C.SECONDARY_SET.Tarot, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			ability_table.counter = pseudorandom_element(Blockbuster.Counters.get_counter_pool({},true), card.config.center_key.."_"..ability_table.pseed)
			local counterobj = Blockbuster.Counters.Counters[ability_table.counter]
			for k,v in ipairs(counterobj.counter_class) do
				if v == "detrimental" then
					ability_table.max_possible = ability_table.max_possible * 3
				end
			end
			StackingUp.func.randvalue_hundreths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_buff then
				local counters = 0
				if G.deck then
					for k,v in ipairs(G.playing_cards) do
						if Blockbuster.Counters.is_counter(v, ability_table.counter) then
							counters = counters + Blockbuster.Counters.get_counter_num(v)
						end
					end
				end
				if counters < 1 then return end
				return {
					buff = 1 + (ability_table.value * counters)
				}
            end
        end,
    },
	stckup_everfrost = countermode and {
		type = {"passive", "cursed"},
        ability = {value = 2, boost = 0.20, min_possible = 1, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
			info_queue[#info_queue+1] = Blockbuster.Counters.Counters["counter_frost"]
			local frosts = 0
			if G.hand then
				for k,v in ipairs(G.hand.cards) do
					if Blockbuster.Counters.is_counter(v, "counter_frost") then
						frosts = frosts + Blockbuster.Counters.get_counter_num(v)
					end
				end
			end
            return {vars = {
				ability_table.boost * 100,
				ability_table.boost * 100 * frosts,
				ability_table.value == 1 and "a" or ability_table.value,
				ability_table.value == 1 and "" or "s",
			},
			background_colour = lighten(G.C.SECONDARY_SET.Tarot, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_buff then
				local frosts = 0
				if G.hand then
					for k,v in ipairs(G.hand.cards) do
						if Blockbuster.Counters.is_counter(v, "counter_frost") then
							frosts = frosts + Blockbuster.Counters.get_counter_num(v)
						end
					end
				end
				if frosts < 1 then return end
				return {
					buff = 1 + (ability_table.boost * frosts)
				}
            end
			if context.after and #G.hand.cards > 0 and not context.blueprint then
				for i = 1, ability_table.value do
					local _target = pseudorandom_element(G.hand.cards, card.config.center_key.."_"..ability_table.pseed)
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.03, func = function()
						card:juice_up()
						return true end
					}))
					_target:bb_counter_apply("counter_frost", 1)
				end
            end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
	},
}

return kinoeffects