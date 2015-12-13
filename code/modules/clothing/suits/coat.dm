/obj/item/clothing/suit/storage/coat
	name = "winter coat"
	desc = "A sturdy coat that can withstand extremely cold temperatures."
	icon_state = "coatwinter"
	item_state = "coatwinter"
	var/open = 0
	var/coat_color_r = 0
	var/coat_color_g = 0
	var/coat_color_b = 0
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HEAD
	allowed = list(/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,/obj/item/device/flashlight/pen)
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	cold_protection = UPPER_TORSO | LOWER_TORSO | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.8

/obj/item/clothing/shoes/leatherboots
	name = "leather boots"
	desc = "A robust pair of boots that protect your feet from the cold."
	icon_state = "leatherboots"
	item_state = "leatherboots"
	body_parts_covered = FEET|LEGS
	allowed = list(/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,/obj/item/device/flashlight/pen)
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	cold_protection = FEET | LEGS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.8


/obj/item/clothing/suit/storage/coat/New()
	..()
	var/icon/newcolorcoat = new/icon("icon" = 'icons/mob/suit.dmi', "icon_state" = "[src.icon_state]")
	newcolorcoat.Blend(rgb(src.coat_color_r, src.coat_color_g, src.coat_color_b), ICON_ADD)
	src.icon = newcolorcoat
/*
	verb/toggle()
		set name = "Toggle coat hood"
		set category = "Object"
		set src in usr

		if(!usr.canmove || usr.stat || usr.restrained())
			return 0

		if (open)
			src.icon_state = "[initial(icon_state)]"
			usr << "You put the hood."
			flags += BLOCKHEADHAIR
		else
			src.icon_state = "[initial(icon_state)]-hood"
			usr << "You removed hood."
			flags -= BLOCKHEADHAIR
		open = !open
		usr.update_inv_wear_suit()	//so our overlays update
*/

/obj/machinery/coat_dispenser
	name = "coat dispenser"
	density = 1
	anchored = 1
	icon = 'icons/obj/vending.dmi'
	icon_state = "cart"
	use_power = 0
	var/accounts = list()

/obj/machinery/coat_dispenser/attackby(O as obj, user as mob)//TODO:SANITY
	if(istype(O, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/idcard = O
		if (idcard.associated_account_number in src.accounts)
			user << "\blue You got your coat already!"
		else
			accounts += idcard.associated_account_number
			var/new_color = input("Please select coat color.", "Coat Dispenser") as color
			var/red_c = hex2num(copytext(new_color, 2, 4))
			var/green_c = hex2num(copytext(new_color, 4, 6))
			var/blue_c = hex2num(copytext(new_color, 6, 8))
			var/obj/item/clothing/suit/storage/coat/C = new/obj/item/clothing/suit/storage/coat(src.loc)
			C.coat_color_r = red_c
			C.coat_color_g = green_c
			C.coat_color_b = blue_c
			var/icon/newcolorcoat = new/icon("icon" = 'icons/mob/suit.dmi', "icon_state" = "[C.icon_state]")
			newcolorcoat.Blend(rgb(C.coat_color_r/1.5, C.coat_color_g/1.5, C.coat_color_b/1.5), ICON_ADD)
			C.icon = newcolorcoat
			new/obj/item/clothing/shoes/leatherboots(src.loc)