local MXMSeffects = {
    stckup_horoscopeslot = {
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
				G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + diff
            end
        end,
        on_apply = function(card, ability_table, repeated)
			G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit + ability_table.value
        end,
        on_remove = function(card, ability_table, card_destroyed)
			G.mxms_horoscope.config.card_limit = G.mxms_horoscope.config.card_limit - ability_table.value
        end,
		load_check = function()
			return Maximus_config.horoscopes
		end,
    },
    stckup_horoscopefund = {
		type = "passive",
        ability = {value = 1, min_possible = 2, max_possible = 5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.value},
			background_colour = lighten(G.C.MONEY, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_default(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_whole(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
			if context.mxms_beat_horoscope and ability_table.value > 0 and not context.blueprint then
				return {
					func = function()
						ease_dollars(ability_table.value)
					end,
					message = localize("$")..ability_table.value
				}
			end
		end,
		load_check = function()
			return Maximus_config.horoscopes
		end,
    },
	stckup_horoscope_scaling = {
		type = "scaling",
		ability = {value = 1, min_possible = 20, max_possible = 40},
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
			if context.mxms_beat_horoscope and ability_table.value > 0 and not context.blueprint then
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
		load_check = function()
			return Maximus_config.horoscopes
		end,
	},
    stckup_horoscope_force = {
		type = "passive",
        ability = {value = 1, min_possible = 0.20, max_possible = 1.00},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * #G.mxms_horoscope.cards,
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
				if #G.mxms_horoscope.cards < 1 then return end
				return {
					buff = 1 + (ability_table.value * #G.mxms_horoscope.cards)
				}
            end
        end,
		load_check = function()
			return Maximus_config.horoscopes
		end,
    },
    stckup_horoscope_gamble = {
		type = {"passive", "cursed"},
        ability = {value = 1, min_possible = 1.00, max_possible = 4.00},
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
            if context.joker_buff then
				return {
					buff = 1 + (ability_table.value)
				}
            end
			if context.mxms_failed_horoscope and not context.blueprint then
				if not SMODS.is_eternal(card) then
					return {
						func = function() card:start_dissolve() end,
						message = "RIP!",
					}
				end
			end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
		load_check = function()
			return Maximus_config.horoscopes
		end,
    },
}

return MXMSeffects