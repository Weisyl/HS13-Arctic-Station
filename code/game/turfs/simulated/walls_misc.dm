/turf/simulated/wall/cult
	name = "wall"
	desc = "The patterns engraved on the wall seem to shift as you try to focus on them. You feel sick"
	icon_state = "cult"
	walltype = "cult"
	builtin_sheet = null

/turf/simulated/wall/cult/break_wall()
	new /obj/effect/decal/cleanable/blood(src)
	new /obj/structure/cultgirder(src)

/turf/simulated/wall/cult/devastate_wall()
	new /obj/effect/decal/cleanable/blood(src)
	new /obj/effect/decal/remains/human(src)

/turf/simulated/wall/cult/narsie_act()
	return

/turf/simulated/wall/vault
	icon_state = "rockvault"

/turf/simulated/wall/rust
	name = "rusted wall"
	desc = "A rusted metal wall."
	icon_state = "arust"
	walltype = "arust"
	hardness = 45

/turf/simulated/wall/r_wall/rust
	name = "rusted reinforced wall"
	desc = "A huge chunk of rusted reinforced metal."
	icon_state = "rrust"
	walltype = "rrust"
	hardness = 15

/turf/simulated/wall/wooden
	name = "wooden wall"
	desc = "A wooden wall."
	icon_state = "wooden"
	mineral = "wood"
	walltype = "wooden"
	hardness = 80
//	sheet_type = /obj/item/stack/sheet/metal/mineral/wood
	slicing_duration = -1		//Not sure if there's a different way to make it invincible to welders.

/turf/simulated/wall/wooden/break_wall()
//	new /obj/structure/woodframe(src)		Future addition of this planned