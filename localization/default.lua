return {
	misc = {
		v_dictionary = {
			stckup_a_m_a_c_value = "+#1#%!",
		},
	},
	ExtraEffectTypes = {
		-- Chain: For context.post_trigger effects
		chain = "Chain",
		-- Aura: For multi-Joker effects
		aura = "Aura",
		-- Scaling: For Potency-increasing effects
		-- This is used as a blacklist for these types of effects, as well
		scaling = "Scaling",
	},
	ExtraEffects = {
		-- BasicEffects.lua
		stckup_handsel = {
			name = "Dexterity",
            text = {
                "Joker gives {C:blue}+#2# Hand",
				"{C:blue}selection limit",
            },
		},
		stckup_discardsel = {
			name = "Clumsiness",
            text = {
                "Joker gives {C:red}+#2# Discard",
				"{C:red}selection limit",
            },
		},
		stckup_consumableslot = {
			name = "Collector's Boon",
            text = {
                "Joker gives {C:purple}+#2#",
				"{C:purple}consumable slot#3#",
            },
		},
		stckup_handleveler = {
			name = "Man I Love #2#",
            text = {
                "Level up {C:attention}#2#{} after",
				"this {C:attention}Joker{} triggers {C:attention}#3#{} time#4#,",
				"then {C:attention}increase{} this threshold",
				"by {C:attention}#5#{} trigger#6#{C:inactive} ({C:attention}#7#{C:inactive} left)",
            },
		},
        stckup_hand_mult = {
            name = "#2# Synergy M",
            text = {
                "{C:attention}Joker{} gives {C:mult}+#1#{} Mult if {C:blue}Hand{}",
				"contains {C:attention}#2#{}",
            },
        },
        stckup_hand_chips = {
            name = "#2# Synergy C",
            text = {
                "{C:attention}Joker{} gives {C:chips}+#1#{} Chips if {C:blue}Hand{}",
				"contains {C:attention}#2#{}",
            },
        },
        stckup_hand_xmult = {
            name = "#2# Synergy X",
            text = {
                "{C:attention}Joker{} gives {C:white,X:mult}X#1#{} Mult if {C:blue}Hand{}",
				"contains {C:attention}#2#{}",
            },
        },
        stckup_small_hands = {
            name = "Small Hands",
            text = {
                "{C:attention}Joker{} gives {C:mult}+#1#{} Mult if {C:blue}Hand{}",
				"contains {C:attention}#2# or fewer{} cards",
            },
        },
        stckup_bj_mult = {
            name = "Blue Jokes M",
            text = {
                "{C:attention}Joker{} gives {C:mult}+#1#{} Mult for",
				"each remaining card in {C:attention}deck",
				"{C:inactive}(Currently: {C:mult}+#2#{C:inactive} Mult)",
            },
        },
        stckup_bj_chips = {
            name = "Blue Jokes C",
            text = {
                "{C:attention}Joker{} gives {C:chips}+#1#{} Chips for",
				"each remaining card in {C:attention}deck",
				"{C:inactive}(Currently: {C:chips}+#2#{C:inactive} Chips)",
            },
        },
        stckup_bj_xmult = {
            name = "Blue Jokes X",
            text = {
                "{C:attention}Joker{} gives {C:white,X:mult}X#1#{} Mult for",
				"each remaining card in {C:attention}deck",
				"{C:inactive}(Currently: {C:white,X:mult}X#2#{C:inactive} Mult)",
            },
        },
        stckup_simplicity = {
            name = "Simplicity",
            text = {
                "{C:mult}+#1#{} Mult",
				"Increases the {C:green}denominator{} of",
				"all {C:green}listed probabilities{} by {C:red}#1#",
            },
        },
        stckup_more_xchips = {
            name = "More XChips",
            text = {
                "{C:white,X:chips}X#1#{} Chips"
            },
        },
        stckup_combo_mult = {
            name = "Comedy Combo M",
            text = {
                "{C:mult}+#1#{} Mult when",
				"this {C:attention}Joker{} triggers"
            },
        },
        stckup_combo_chips = {
            name = "Comedy Combo C",
            text = {
                "{C:chips}+#1#{} Chips when",
				"this {C:attention}Joker{} triggers"
            },
        },
        stckup_combo_xmult = {
            name = "Comedy Combo X",
            text = {
                "{C:white,X:mult}X#1#{} Mult when",
				"this {C:attention}Joker{} triggers"
            },
        },
        stckup_fadeout = {
            name = "Fadeout",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
				"for each card below {C:attention}#2#{} in your {C:attention}full deck",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#3#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_enh_force = {
            name = "#2# Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"each {C:attention}#2#{} in your {C:attention}full deck",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#3#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_hang_in_there = {
            name = "Hang In There, \\##2#!",
            text = {
                "Retrigger the {C:attention}#3#{} played card",
				"used in scoring {C:attention}#1#{} time#4#",
            },
        },
        stckup_bigger_picture = {
            name = "Bigger Picture",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
				"for each {C:attention}Joker{} card",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_hardboiled = {
            name = "Hard-Boiled",
            text = {
                "Joker gains {C:money}$#1#{} of {C:attention}sell",
				"{C:attention}value{} at end of round",
            },
        },
		stckup_hiking = {
            name = "Hiking",
            text = {
                "Scored cards permanently",
				"gain {C:chips}+#1#{} Chips when scored",
            },
        },
        stckup_lounging = {
            name = "Lounging",
            text = {
                "Cards held in hand permanently",
				"gain {C:chips}+#1#{} Chips when held in hand",
            },
        },
        stckup_dramatic_entrance = {
            name = "Dramatic Entrance",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
				"on {C:attention}first hand of round",
            },
        },
        stckup_grand_finale = {
            name = "Grand Finale",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
				"on {C:attention}final hand of round",
            },
        },
        stckup_critical_chance = {
            name = "Critical Chance",
            text = {
                "{C:green}#1#%{} chance for this Joker to",
				"give {X:stck_m_a_c,C:white}#2#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
            },
        },
		
		-- AMMEffects.lua
		stckup_suitleveler = {
			name = "Apprentice of {V:2}#2#{}",
            text = {
                "Level up {V:2}#2#{} suit after",
				"this {C:attention}Joker{} triggers {C:attention}#3#{} time#4#,",
				"then {C:attention}increase{} this threshold",
				"by {C:attention}#5#{} trigger#6#{C:inactive} ({C:attention}#7#{C:inactive} left)",
            },
		},
        stckup_cq_mult = {
            name = "#3# Synergy M",
            text = {
                "Scored {C:attention}#2#{} cards",
                "give {C:mult}+#1#{} Mult",
            },
        },
        stckup_cq_chips = {
            name = "#3# Synergy C",
            text = {
                "Scored {C:attention}#2#{} cards",
                "give {C:chips}+#1#{} Chips",
            },
        },
        stckup_cq_xmult = {
            name = "#3# Synergy X",
            text = {
                "Scored {C:attention}#2#{} cards",
                "give {C:white,X:mult}X#1#{} Mult",
            },
        },
        stckup_first_cq_mult = {
            name = "#3# First Strike M",
            text = {
                "First scored {C:attention}#2#{}",
                "card gives {C:mult}+#1#{} Mult",
            },
        },
        stckup_first_cq_chips = {
            name = "#3# First Strike C",
            text = {
                "First scored {C:attention}#2#{}",
                "card gives {C:chips}+#1#{} Chips",
            },
        },
        stckup_first_cq_xmult = {
            name = "#3# First Strike X",
            text = {
                "First scored {C:attention}#2#{}",
                "card gives {C:white,X:mult}X#1#{} Mult",
            },
        },
        stckup_skulking = {
            name = "Skulking",
            text = {
                "Unscored played cards permanently",
				"gain {C:chips}+#1#{} Chips when unscoring",
            },
        },
        stckup_cq_force = {
            name = "#4# Card Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"each {C:attention}#3#{} card in your {C:attention}full deck",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
		stckup_cq_spawner = {
			name = "#4# Card Printer",
			text = {
				"When round begins, add {C:attention}#1#{} random",
				"{C:attention}#3# card#2#{} to your hand",
			},
		},
        stckup_grave_force = {
            name = "Grave Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"each card in your {C:attention}graveyard",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
		
		-- ScalingEffects.lua
        stckup_simple_scaling = {
            name = "Simple Scaling",
            text = {
                "Increase the {C:attention}Potency{} of a random {C:attention}Effect",
				"of this Joker by {C:attention}#1#%{} at end of round",
            },
        },
        stckup_caino = {
            name = "Canio's Mark: #3#",
            text = {
                "Increase the {C:attention}Potency{} of this",
				"Joker's {C:attention}Effects{} by {C:attention}#1#%{} when",
				"a#4# {C:attention}#2#{} card is destroyed",
            },
        },
        stckup_yorick = {
            name = "Essence of Yorick",
            text = {
                "Increase the {C:attention}Potency{} of this",
				"Joker's {C:attention}Effects{} by {C:attention}#1#%{} every",
				"{C:attention}#2#{C:inactive} [#3#]{} cards discarded",
            },
        },
		
		-- CrossMod/0-ERROR.lua
        stckup_incrementalist = {
            name = "#1# Incrementalist",
            text = {
                "Creates a#2# {C:attention}#1#{} after",
				"this {C:attention}Joker{} triggers {C:attention}#3#{} times",
				"{C:inactive}(Must have room, {C:attention}#4#{C:inactive} left)",
				
            },
        },
		
		-- CrossMod/GrabBag.lua
		stckup_hexing_jesting = {
			name = "Hexing Jesting",
            text = {
				"Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
				"for each {V:1}Hex{} in your {C:attention}full deck{}",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
				"{s:0.15} ",
				"A random card in your {C:attention}full deck",
				"becomes {C:attention}#3#{} at end of round",
            },
		},
        stckup_mist_force = {
            name = "Mist Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"every {C:inactive}Ephemeral Card{} used this run",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
		
		-- CrossMod/HotPotato.lua
        stckup_ad_combo = {
            name = "{C:hpot_advert}Ad{} Combo",
            text = {
                "{C:hpot_advert}+#1# Ad#2#{} when",
				"this {C:attention}Joker{} triggers"
            },
        },
        stckup_plincoin_combo = {
            name = "{f:hpot_plincoin,C:hpot_plincoin}$lincoin{} Combo",
            text = {
                "{C:hpot_plincoin}+#1#{f:hpot_plincoin,C:hpot_plincoin} $lincoin#2#{} when",
				"this {C:attention}Joker{} triggers"
            },
        },
        stckup_crypto_combo = {
            name = "{f:hpot_plincoin,C:hpot_advert}£ryptocurrency{} Combo",
            text = {
                "{C:hpot_advert}+#1# {f:hpot_plincoin,X:hpot_advert,C:white}£{C:hpot_advert}ryptocurrency{} when",
				"this {C:attention}Joker{} triggers"
            },
        },
        stckup_jicks_combo = {
            name = "{f:hpot_plincoin,C:blue}͸icks{} Combo",
            text = {
                "{C:blue}+#1#{f:hpot_plincoin,C:blue} ͸icks{} when",
				"this {C:attention}Joker{} triggers"
            },
        },
        stckup_plinko_force = {
            name = "I'm {C:hpot_plincoin}Plinking{} It",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"every {C:hpot_plincoin}Plinko{} played this run",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_ad_force = {
            name = "{C:hpot_advert}Ad{} Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"every {C:hpot_advert}Ad{} open",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_indecisiveness = {
            name = "Indecisiveness",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"every {C:attention}Delivery{} refunded while owned",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_back_alley_window_shopper = {
            name = "Back Alley Window Shopper",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"every time the {C:hpot_advert}Black Market{} has",
				"been rerolled while owned",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
		
		-- CrossMod/JoyousSpring.lua
        stckup_attr_mult = {
            name = "{V:1}#2#{} Synergy M",
            text = {
                "{V:1}#2#{C:attention} Jokers{} give {C:mult}+#1#{} Mult",
            },
        },
        stckup_attr_chips = {
            name = "{V:1}#2#{} Synergy C",
            text = {
                "{V:1}#2#{C:attention} Jokers{} give {C:chips}+#1#{} Chips",
            },
        },
        stckup_attr_xmult = {
            name = "{V:1}#2#{} Synergy X",
            text = {
                "{V:1}#2#{C:attention} Jokers{} give {X:mult,C:white}X#1#{} Mult",
            },
        },
        stckup_ygotype_mult = {
            name = "{C:joy_normal}#2#{} Synergy M",
            text = {
                "{C:joy_normal}#2#{C:attention} Jokers{} give {C:mult}+#1#{} Mult",
            },
        },
        stckup_ygotype_chips = {
            name = "{C:joy_normal}#2#{} Synergy C",
            text = {
                "{C:joy_normal}#2#{C:attention} Jokers{} give {C:chips}+#1#{} Chips",
            },
        },
        stckup_ygotype_xmult = {
            name = "{C:joy_normal}#2#{} Synergy X",
            text = {
                "{C:joy_normal}#2#{C:attention} Jokers{} give {X:mult,C:white}X#1#{} Mult",
            },
        },
        stckup_bonus_attr = {
            name = "{V:1}#1#{}-Attuned",
            text = {
                "{C:attention}Joker{} is also {V:1}#1#{}",
            },
        },
        stckup_bonus_ygotype = {
            name = "Form of {C:joy_normal}#1#{}",
            text = {
                "{C:attention}Joker{} is also a#2# {C:joy_normal}#1#{}",
            },
        },
        stckup_phasing = {
            name = "Phasing",
            text = {
                "When {C:attention}Blind{} is selected, {C:attention}banish{} this",
				"{C:attention}Joker{} until {C:attention}next Blind{} is selected",
            },
        },
        stckup_hypervisor = {
            name = "Hypervisor",
            text = {
				"Enables Virtual World hands",
            },
        },
		
		-- CrossMod/Kino.lua
        stckup_magazine = {
            name = "Magazine",
            text = {
                "Counts as {C:attention}#1#{} Bullet#2#",
            },
        },
        stckup_spellcaster = {
            name = "Spellcaster",
            text = {
				"{C:attention}Joker{} casts a {C:purple,E:1}Spell{} based",
				"on the first two cards held",
				"in hand and a#2# {C:attention}#1#{}'s power",
            },
        },
        stckup_genre_whiplash = {
            name = "Genre Whiplash",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
				"for each {C:attention}unique Genre{} among your {C:attention}Jokers{}",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_more_dakka = {
            name = "More Dakka",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more",
				"{C:chips}Chips{}/{C:mult}Mult{} for each Bullet",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
        stckup_genre_hater = {
            name = "{V:1}#3#{} Hater",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for",
				"each non-{V:1}#3# {C:attention}Movie Joker{}",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
		stckup_conflagration = {
			name = "Conflagration",
            text = {
				"Jokers and played cards with {C:attention}Burn",
				"{C:attention}Counters{} give {X:mult,C:white}X#1#{} Mult when scored",
				"{s:0.15} ",
				"Put a {C:attention}Burn Counter{} on a random card",
				"held in hand after {C:blue}Hand{} is played",
            },
		},
        stckup_truant = {
            name = "Truant",
            text = {
				"Put a {C:attention}Stun Counter{} on",
				"this {C:attention}Joker{} after it triggers"
            },
        },
        stckup_counter_up = {
            name = "Counter Up",
            text = {
				"If this {C:attention}Joker{} has a {C:attention}Counter{}",
				"on it, it gains {C:attention}#1#{} of that type",
				"of {C:attention}Counter{} at end of round",
            },
        },
        stckup_held_counter = {
            name = "#2#holder",
            text = {
				"Distribute #1# {C:attention}#2##3#{}",
				"randomly among cards held",
				"in hand at end of round",
            },
        },
        stckup_counter_force = {
            name = "#3# Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for each",
				"{C:attention}#3#{} on cards in your {C:attention}full deck",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
		stckup_everfrost = {
			name = "Everfrost",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for each",
				"{C:attention}Frost Counter{} on cards held in hand",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
				"{s:0.15} ",
				"Put a {C:attention}Frost Counter{} on {C:attention}#3#{} random card#4#",
				"held in hand after {C:blue}Hand{} is played",
            },
		},
		
		-- CrossMod/Maximus.lua
		stckup_horoscopeslot = {
			name = "Horoscope Fanatic",
            text = {
                "Joker gives {C:attention}+#2#",
				"{C:horoscope}horoscope slot#3#",
            },
		},
		stckup_horoscopefund = {
			name = "Horoscope Trust Fund",
            text = {
                "Earn {C:money}$#1#{} after a",
				"{C:horoscope}Horoscope{} card is fulfilled",
            },
		},
        stckup_horoscope_scaling = {
            name = "Horoscope Scaling",
            text = {
                "Increase the {C:attention}Potency{} of a random",
				"{C:attention}Effect{} of this Joker by {C:attention}#1#%{}",
				"after a {C:horoscope}Horoscope{} card is fulfilled",
            },
        },
        stckup_horoscope_force = {
            name = "Horoscope Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} for each",
				"{C:horoscope}Horoscope{} card currently held",
            },
        },
        stckup_horoscope_gamble = {
            name = "Horoscope Gamble",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{} but is",
				"{C:red,s:1.1,E:1}destroyed{} if a {C:horoscope}Horoscope{} card fails",
            },
        },
		
		-- CrossMod/MoreFluff.lua
		stckup_colour_by_jokes = {
			name = "Colour-By-Jokes",
            text = {
                "Each held {C:colour}Colour{} card gains",
				"{C:attention}1 round{} after this Joker",
				"triggers {C:attention}#1#{} time#2# {C:inactive}({C:attention}#3#{C:inactive} left)",
            },
		},
		
		-- CrossMod/Pokermon.lua
        stckup_poketype_mult = {
            name = "{V:1}#2#{}-Type Synergy M",
            text = {
                "{V:1}#2#{}-type{C:attention} Jokers{} give {C:mult}+#1#{} Mult",
            },
        },
        stckup_poketype_chips = {
            name = "{V:1}#2#{}-Type Synergy C",
            text = {
                "{V:1}#2#{}-type{C:attention} Jokers{} give {C:chips}+#1#{} Chips",
            },
        },
        stckup_poketype_xmult = {
            name = "{V:1}#2#{}-Type Synergy X",
            text = {
                "{V:1}#2#{}-type{C:attention} Jokers{} give {X:mult,C:white}X#1#{} Mult",
            },
        },
        stckup_hazard_setter = {
            name = "Hazard Setter",
            text = {
				"{C:purple}+#1# Hazards",
            },
        },
        stckup_future_sight = {
            name = "Future Sight",
            text = {
				"{C:purple}+#1# Foresight",
            },
        },
        stckup_spikes = {
            name = "Spikes Setter",
            text = {
				"{C:purple}+3 Hazards",
				"{C:purple}Hazard Cards{} held in hand",
				"give {C:mult}+#1#{} Mult",
            },
        },
        stckup_tspikes = {
            name = "Toxic Spikes Setter",
            text = {
				"{C:purple}+2 Hazards",
				"{C:purple}Hazard Cards{} held in hand",
				"reduce {C:attention}Blind{} size by {X:attention,C:white}#1#%{}",
            },
        },
        stckup_stealth_rock = {
            name = "Stealth Rock Setter",
            text = {
				"{C:purple}+1 Hazards",
				"{C:purple}Hazard Cards{} held in hand",
				"give {X:chips,C:white}X#1#{} Chips",
            },
        },
		
		-- CrossMod/RudeBuster.lua
        stckup_loyalty_gain = {
            name = "Loyalty Gain",
            text = {
				"Joker gains +#1# {C:dark_edition}Loyalty{}",
				"at end of round",
            },
        },
        stckup_loyalty_haste = {
            name = "Loyalty Haste",
            text = {
				"Joker can use its {C:dark_edition}Loyalty{}",
				"abilities {C:attention}#1#{} more time#2# per Round",
            },
        },
		
		-- CrossMod/Vall-Karri.lua
        stckup_kitty_therian = {
            name = "Kitty Therian",
            text = {
                "Counts as a {C:attention}Kitty{} Joker",
            },
        },
        stckup_kitty_force = {
            name = "Kitty Force",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}#1#%{} more {C:chips}Chips{}/{C:mult}Mult{}",
				"for each {C:attention}Kitty{} Joker",
				"{C:inactive}(Currently: {X:stck_m_a_c,C:white}#2#%{C:inactive} more Chips/Mult)",
            },
        },
		stckup_kitty_combo = {
			name = "Kitty Combo",
            text = {
                "Create a {C:attention}Kitty Tag{} after this",
				"{C:attention}Joker{} triggers {C:attention}#1#{} time#2# {C:inactive}({C:attention}#3#{C:inactive} left)",
            },
		},
        
	},
}