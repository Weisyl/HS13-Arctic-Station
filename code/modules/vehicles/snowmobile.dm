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
	if(istype(user.l_hand, /obj/item/key/security) || istype(user.r_hand, /obj/item/key/security))
		if(!Process_Spacemove(direction))
			return
		step(src, direction)
		update_mob()
		handle_rotation()
	else
		user << "<span class='notice'>You'll need the keys in one of your hands to drive this [callme].</span>"

/obj/structure/stool/bed/chair/janicart/snowmobile/update_mob()
	if(buckled_mob)
		buckled_mob.dir = dir
		switch(dir)
			if(SOUTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 7
			if(WEST)
				buckled_mob.pixel_x = 6
				buckled_mob.pixel_y = 2
			if(NORTH)
				buckled_mob.pixel_x = 0
				buckled_mob.pixel_y = 10
			if(EAST)
				buckled_mob.pixel_x = -6
				buckled_mob.pixel_y = 2