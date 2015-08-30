/obj/structure/stool/bed/chair/janicart/snowmobile
	name = "Snowmobile"
	desc = "A treaded snowmobile. An excellent means of transportation in the arctic."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "snowmobile"
	callme = "Snowmobile"
	anchored = 1 //This is rather heavy

/obj/structure/stool/bed/chair/janicart/snowmobile/relaymove(mob/user as mob, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle_mob()
	if(istype(user.l_hand, /obj/item/key/snowmobile) || istype(user.r_hand, /obj/item/key/snowmobile))
		if(!Process_Spacemove(direction))
			return
		step(src, direction)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this [callme].</span>"

obj/structure/stool/bed/chair/janicart/snowmobile/relaymove(mob/user as mob, direction)
	if(user.stat || user.stunned || user.weakened || user.paralysis)
		unbuckle_mob()
	else
		step(src, direction)
		update_mob()
		handle_rotation()