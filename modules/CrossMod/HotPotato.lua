local alias__G_FUNCS_hp_jtem_cancel = G.FUNCS.hp_jtem_cancel
G.FUNCS.hp_jtem_cancel = function(e)
    local card = e.config.ref_table
    local object = card.ability.hp_delivery_obj
    local returncost = math.ceil(object.price * 0.5)
    SMODS.calculate_context{hpot_refunded_card = card, hpot_refunded_currency = object.currency, hpot_refunded_cost = returncost}
	return alias__G_FUNCS_hp_jtem_cancel(e)
    --hotpot_delivery_refresh_card()
end

local hoteffects = {
    stckup_ad_combo = {
		type = {"chain", "cursed"},
        ability = {value = 1, min_possible = 1, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				ability_table.value == 1 and "" or "s",
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
            if context.post_trigger and context.other_card == card and context.other_ret then
				return {
					func = function()
						create_ads(ability_table.value)
					end,
				}
            end
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
    },
    stckup_plincoin_combo = {
		type = {"chain"},
        ability = {value = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
				ability_table.value == 1 and "" or "s",
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
            if context.post_trigger and context.other_card == card and context.other_ret then
				return {
					func = function()
						ease_plincoins(ability_table.value)
					end,
				}
            end
        end,
    },
    stckup_crypto_combo = {
		type = {"chain"},
        ability = {value = 0.3, min_possible = 0.1, max_possible = 0.6},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value,
			},
			background_colour = lighten(G.C.IMPORTANT, StackingUp.bg_contrast)}
        end,
        randomize_values = function(card, ability_table)
			StackingUp.func.randvalue_tenths(card, ability_table)
		end,
        update_values = function(card, ability_table)
			StackingUp.func.updvalue_tenths(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.post_trigger and context.other_card == card and context.other_ret then
				return {
					func = function()
						ease_cryptocurrency(ability_table.value)
					end,
				}
            end
        end,
    },
    stckup_jicks_combo = {
		type = {"chain"},
        ability = {value = 3, min_possible = 100, max_possible = 10000},
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
			StackingUp.func.updvalue_default(card, ability_table)
		end,
        calculate = function(card, context, ability_table, ability_index)
            if context.post_trigger and context.other_card == card and context.other_ret then
				return {
					func = function()
						ease_spark_points(ability_table.value)
					end,
				}
            end
        end,
    },
    stckup_plinko_force = {
		type = "passive",
        ability = {value = 1, min_possible = 0.05, max_possible = 0.34},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * G.GAME.balls_dropped,
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
				if G.GAME.balls_dropped < 1 then return end
				return {
					buff = 1 + (ability_table.value * G.GAME.balls_dropped)
				}
            end
        end,
    },
    stckup_ad_force = {
		type = "passive",
        ability = {value = 1, min_possible = 0.03, max_possible = 0.22},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				ability_table.value * 100 * #G.GAME.hotpot_ads,
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
				if #G.GAME.hotpot_ads < 1 then return end
				return {
					buff = 1 + (ability_table.value * #G.GAME.hotpot_ads)
				}
            end
        end,
    },
    stckup_indecisiveness = {
		type = "passive",
        ability = {value = 0.20, bonus = 0, min_possible = 0.12, max_possible = 0.25},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				ability_table.bonus * 100,
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
				if ability_table.bonus <= 0 then return end
				return {
					buff = 1 + (ability_table.bonus)
				}
            end
			if context.hpot_refunded_card then
				SMODS.scale_card(card, {
					ref_table = ability_table,
					ref_value = "bonus",
					scalar_value = "value",
					scaling_message = {
						message = localize{
							type = 'variable',
							key = 'stckup_a_m_a_c_value',
							vars = {
								math.floor(ability_table.value * 100)
							},
						},
						colour = G.C.PURPLE,
					},
				})
			end
        end,
    },
    stckup_back_alley_window_shopper = {
		type = "passive",
        ability = {value = 0.20, bonus = 0, min_possible = 0.06, max_possible = 0.66},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {
				ability_table.value * 100,
				ability_table.bonus * 100,
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
				if ability_table.bonus <= 0 then return end
				return {
					buff = 1 + (ability_table.bonus)
				}
            end
			if context.reroll_market then
				SMODS.scale_card(card, {
					ref_table = ability_table,
					ref_value = "bonus",
					scalar_value = "value",
					scaling_message = {
						message = localize{
							type = 'variable',
							key = 'stckup_a_m_a_c_value',
							vars = {
								math.floor(ability_table.value * 100)
							},
						},
						colour = G.C.PURPLE,
					},
				})
			end
        end,
    },
}

SMODS.Atlas{
	key = 'ad_bepis',
	px = 300,
	py = 300,
	path = 'ad_bepis.png',
	atlas_table = "ASSET_ATLAS"
}

HotPotato.Ads.Adverts.ad_stckup_bepis = {
	atlas = "stckup_ad_bepis",
	pos = {x = 0, y = 0},
	base_size = 0.5,
}

return hoteffects