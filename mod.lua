StackingUp = {}
StackingUp.mod = SMODS.current_mod

StackingUp.func = {
	randvalue_default = function(card, ability_table)
		ability_table.perfect = Stacked.poll_potency{seed = ability_table.pseed.."_roll", min = 0, max = ability_table.max_possible - ability_table.min_possible}
		ability_table.value = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
	end,
	updvalue_default = function(card, ability_table)
		if not ability_table.perfect then StackingUp.func.randvalue_default(card,ability_table) end
		ability_table.value = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
		ability_table.value = Stacked.round(ability_table.value, 2)
	end,
	updvalue_whole = function(card, ability_table)
		if not ability_table.perfect then StackingUp.func.randvalue_default(card,ability_table) end
		ability_table.value = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
		ability_table.value = Stacked.round(ability_table.value, 0)
	end,
	randvalue_inverse = function(card, ability_table)
		ability_table.perfect = Stacked.poll_potency{seed = ability_table.pseed.."_roll", min = 0, max = ability_table.max_possible - ability_table.min_possible}
		ability_table.value = (ability_table.max_possible) - ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
	end,
	updvalue_inverse = function(card, ability_table)
		if not ability_table.perfect then StackingUp.func.randvalue_inverse(card,ability_table) end
		ability_table.value = (ability_table.max_possible) - ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
		ability_table.value = Stacked.round(ability_table.value, 2)
	end,
	randvalue_tenths = function(card, ability_table)
		ability_table.perfect = Stacked.poll_potency{seed = ability_table.pseed.."_roll", min = 0, max = (ability_table.max_possible - ability_table.min_possible) * 10, round = 0.1}
		ability_table.value = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
		ability_table.value = Stacked.round(ability_table.value, 1)
	end,
	randvalue_hundreths = function(card, ability_table)
		ability_table.perfect = Stacked.poll_potency{seed = ability_table.pseed.."_roll", min = 0, max = (ability_table.max_possible - ability_table.min_possible) * 100, round = 0.01}
		ability_table.value = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
		ability_table.value = Stacked.round(ability_table.value, 2)
	end,
	updvalue_tenths = function(card, ability_table)
		if not ability_table.perfect then StackingUp.func.randvalue_tenths(card,ability_table) end
		ability_table.value = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
		ability_table.value = Stacked.round(ability_table.value, 1)
	end,
	cardquality_value = function(value, quality)
		if AMM.qualities[quality] and type(AMM.qualities[quality].value_mod) == "function" then
			value = AMM.qualities[quality].value_mod(value)
		end
		value = math.floor(value * 100) / 100
		return value
	end,
	scalingeffect = function(args)
		if not args.cards then
			if args.card then
				args.cards = {args.card}
			end
		end
		for _, card in ipairs(args.cards) do
			local effects = card.ability.hsr_extra_effects
			local target = -1
			if args.mode == "random" then
				local _effects = {}
				for __,effect in ipairs(effects) do
					local extraeffect = ExtraEffects[effect.key]
					local doit = true
					if extraeffect.no_potency then doit = false end
					if not type(effect.ability.perfect) == "number" then doit = false end
					if type(extraeffect.type) == "table" then
						for ___, _type in ipairs(extraeffect.type) do
							if _type == "scaling" then doit = false end
						end
					elseif type(extraeffect.type) == "string" and extraeffect.type == "scaling" then
						doit = false
					end
					if doit then
						_effects[#_effects+1] = {effect, __}
					end
				end
				if #_effects == 0 then
					target = nil
				end
				target = pseudorandom_element(_effects, args.pseed)[2]
			end
			if args.mode ~= "random" or target then
				for __, effect in ipairs(effects) do
					local extraeffect = ExtraEffects[effect.key]
					local doit = true
					if args.mode == "random" then
						if __ ~= target then
							doit = false
						end
					elseif args.mode ~= "random" then
						if extraeffect.no_potency then doit = false end
						if not type(effect.ability.perfect) == "number" then doit = false end
						if type(extraeffect.type) == "table" then
							for ___, _type in ipairs(extraeffect.type) do
								if _type == "scaling" then doit = false end
							end
						elseif type(extraeffect.type) == "string" and extraeffect.type == "scaling" then
							doit = false
						end
					end
					if doit == true then
						-- just in case somehow it's above our cap
						local originalperfect = effect.ability.perfect
						effect.ability.perfect = effect.ability.perfect + (args.amt or args.val or args.value or args.amount) -- listen i am inconsistent
						effect.ability.perfect = math.max(math.min(effect.ability.perfect,
							(G.GAME.hsr_potency_cap or 100) * (G.GAME.thacked_scaling_cap or 1)
						), originalperfect) -- holy abomination of math
					end
				end
			end
		end
	end,
}

StackingUp.mod.optional_features = function()
	return {
		retrigger_joker = true,
        --quantum_enhancements = true,
		post_trigger = true,
        cardareas = {
            unscored = true,
            --graveyard = true,
        },
        amm_suit_levels = true,
		amm_graveyard = true,
	}
end

StackingUp.bg_contrast = 0.90
-- bg key:
-- mult effect: G.C.MULT
-- chips effect: G.C.CHIPS
-- xmult effect: G.C.XMULT
-- xchips effect: G.C.CHIPS
-- $ effect: G.C.MONEY
-- chips/mult buff effect: G.C.SECONDARY_SET.Tarot
-- passive effect: G.C.SECONDARY_SET.Planet
-- consumable type related effect: G.C.SECONDARY_SET[_type]
-- misc effect: G.C.IMPORTANT

local effects = {
	NFS.load(StackingUp.mod.path.."modules/BasicEffects.lua")(),
	NFS.load(StackingUp.mod.path.."modules/AMMEffects.lua")(),
	NFS.load(StackingUp.mod.path.."modules/ScalingEffects.lua")(),
	NFS.load(StackingUp.mod.path.."modules/CrossMod/Kino.lua")(),
}

if next(SMODS.find_mod("GrabBag")) then effects[#effects+1] = NFS.load(StackingUp.mod.path.."modules/CrossMod/GrabBag.lua")() end
if next(SMODS.find_mod("JoyousSpring")) then effects[#effects+1] = NFS.load(StackingUp.mod.path.."modules/CrossMod/JoyousSpring.lua")() end
if next(SMODS.find_mod("Maximus")) then effects[#effects+1] = NFS.load(StackingUp.mod.path.."modules/CrossMod/Maximus.lua")() end
if next(SMODS.find_mod("MoreFluff")) then effects[#effects+1] = NFS.load(StackingUp.mod.path.."modules/CrossMod/MoreFluff.lua")() end
if next(SMODS.find_mod("Pokermon")) then effects[#effects+1] = NFS.load(StackingUp.mod.path.."modules/CrossMod/Pokermon.lua")() end
if next(SMODS.find_mod("RudeBuster")) then effects[#effects+1] = NFS.load(StackingUp.mod.path.."modules/CrossMod/RudeBuster.lua")() end
if next(SMODS.find_mod("vallkarri")) then effects[#effects+1] = NFS.load(StackingUp.mod.path.."modules/CrossMod/VallKarri.lua")() end


local count = 0

print("[ Uninteractable Yaplog ]")

for _,batch in ipairs(effects) do
	for k,v in pairs(batch) do
		v.key = k
		v.ability.pseed = k
		if (not v.load_check) or (type(v.load_check) == "function" and v:load_check()) then
			print("[STACKINGUP] Loaded effect with key "..k)
			Stacked.extra_effect(v)
			count = count + 1
		end
	end
end

math.randomseed(os.time())
local yaps = {
	function()
		print("AM: stackingup load3d!")
		print("AM: r3gist3r3d "..count.." 3ff3cts!")
	end,
	function()
		print("NG: StackingUp loaded. Everything seems in order.")
		print("NG: "..count.." more effects for you to stack.")
	end,
	function()
		print("[STACKINGUP] Load message.")
		print("[STACKINGUP] "..count.." effects loaded.")
	end,
	function()
		print("* STACKINGUP has loaded!")
		print("* STACKINGUP has added "..count.." effects to Stacked!")
	end,
}
yaps[math.random(#yaps)]()
local load_quips = {
	"NG: ok",
	"NG: can you do that with less talking",
	"AM: ... anyon3 list3ning?",
	"                     Hello...?",
	"NG: now we can play the game",
	"AM: hi im in ur consol3",
	"AM: it is customary that i say som3thing h3r3",
	"* Well, there are three people here.",
	"* Well, there are not three people here.",
	"* Well, there were three people here.",
	"* Well, you're here.",
	"* Well, you're still here.",
	"* Well, you're back.",
	"* You feel the effects stacking up.",
	"* You feel your effects stacking on your back.",
	"* You hear a call from the abyss.",
	"* You hear a call from a wrong number.",
	"* You hear scratching.",
	"* The air crackles with free mods.",
	"* The air crackles with freedom.",
	"* The effects want to stack.",
	"* The north wind stacks up.",
	"* ###### grew pale.",
	"* ###### fell down.",
	"* #### became a pile of ####.",
	"NG: stay sharp",
	"AM: m3ow",
	"AM: m3owm3owm3owm3owm3owm3owm3owm3owm3owm3owm3owm3ow",
	"AM: aft3r you'v3 glimps3d th3 void... can you still b3 you?",
}
	print(load_quips[math.random(#load_quips)])