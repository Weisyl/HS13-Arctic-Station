/*
/obj/structure/woodenwall()
	if(istype(src,/turf/simulated/wall/vault)) //HACK!!!
		return
	var/junction = 0 //will be used to determine from which side the wall is connected to other walls
	for(var/obj/structure/woodenwall/W in orange(src,1))
		if(abs(src.x-W.x)-abs(src.y-W.y)) //doesn't count diagonal walls
			if(src.mineral == W.mineral)//Only 'like' walls connect -Sieve
				junction |= get_dir(src,W)
	var/turf/simulated/wall/wall = src
	wall.icon_state = "[wall.walltype][junction]"
	return

/obj/structure/woodenwall/proc/relativewall_neighbours()
	for(var/obj/structure/woodenwall/W in range(src,1))
		W.relativewall()
	return
*/

/obj/structure/woodenwall/proc/relativewall()

	var/junction = 0 //will be used to determine from which side the wall is connected to other walls

	for(var/obj/structure/woodenwall/W in orange(src,1))
		if(abs(src.x-W.x)-abs(src.y-W.y)) //doesn't count diagonal walls
			if(src.mineral == W.mineral)
				junction |= get_dir(src,W)
	icon_state = "[mineral][junction]"
	return


/obj/structure/woodenwall/proc/relativewall_neighbours()
	for(var/obj/structure/woodenwall/S in range(src,1))
		S.relativewall()
		S.update_icon()
	return

/obj/structure/woodenwall/Del()

	loc = src.loc

	spawn(10)
		for(var/obj/structure/woodenwall/W in range(loc,1))
			W.relativewall()
	relativewall_neighbours()
	..()
/*
/obj/structure/woodenwall/update_icon()//Calling icon_update will refresh the smoothwalls if it's closed, otherwise it will make sure the icon is correct if it's open
	..()
	icon_state = "[mineral]0"
	src.relativewall()
*/
/obj/structure/woodenwall
	name = "wooden wall"
	desc = "Nash sovietsky soyuz pokaraet ves mir ot Evropi, k Neve na vostok, nad zemley vezde budut pet: Stolica, vodka, sovtskiy medved nash!."
	icon = 'icons/obj/wooden_walls.dmi'
	icon_state = "wall"
	anchored = 1
	density = 1
	opacity = 1
	layer = FLY_LAYER
	var/mineral = "wood"
	var/health = 300.0
	var/maxhealth = 300.0
	var/temploc

	attackby(obj/item/O as obj, mob/user as mob)
		if (istype(O, /obj/item/stack/sheet/mineral/wood))
			if (src.health < src.maxhealth)
				visible_message("\red [user] begins to repair the [src]!")
				if(do_after(user,20))
					src.health = src.maxhealth
					O:use(1)
					visible_message("\red [user] repairs the [src]!")
					return
			else
				return
			return
		else
			switch(O.damtype)
				if("burn")
					src.health -= O.force * 1
				if("brute")
					src.health -= O.force * 0.75
				else
			if (src.health <= 0)
				visible_message("\red <B>The wall is smashed apart!</B>")
				new /obj/item/stack/sheet/mineral/wood(get_turf(src))
				new /obj/item/stack/sheet/mineral/wood(get_turf(src))
				new /obj/item/stack/sheet/mineral/wood(get_turf(src))
				temploc = src.loc
				spawn(10)
				for(var/obj/structure/woodenwall/W in range(temploc,1))
					W.relativewall()
				relativewall_neighbours()
				del(src)
			..()

/obj/structure/woodenwall/New()
	relativewall_neighbours()
	..()

/obj/structure/barricade/window
	name = "wooden window"
	desc = "A plain, but rather classy window in a wooden frame."
	icon = 'icons/obj/wooden_walls.dmi'
	icon_state = "window"
	anchored = 1.0
	density = 1.0
	layer = FLY_LAYER
	var/health = 100.0
	var/maxhealth = 100.0

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, /obj/item/stack/sheet/mineral/wood))
			if (src.health < src.maxhealth)
				visible_message("\red [user] begins to repair the [src]!")
				if(do_after(user,20))
					src.health = src.maxhealth
					W:use(1)
					visible_message("\red [user] repairs the [src]!")
					return
			else
				return
			return
		else
			switch(W.damtype)
				if("burn")
					src.health -= W.force * 1
				if("brute")
					src.health -= W.force * 0.75
				else
			if (src.health <= 0)
				visible_message("\red <B>The window is smashed apart!</B>")
				new /obj/item/stack/sheet/mineral/wood(get_turf(src))
				new /obj/item/stack/sheet/mineral/wood(get_turf(src))
				new /obj/item/stack/sheet/mineral/wood(get_turf(src))
				del(src)
			..()

	ex_act(severity)
		switch(severity)
			if(1.0)
				visible_message("\red <B>The window is smashed apart!</B>")
				del(src)
				return
			if(2.0)
				src.health -= 25
				if (src.health <= 0)
					visible_message("\red <B>The window is smashed apart!</B>")
					new /obj/item/stack/sheet/mineral/wood(get_turf(src))
					new /obj/item/stack/sheet/mineral/wood(get_turf(src))
					new /obj/item/stack/sheet/mineral/wood(get_turf(src))
					del(src)
				return

	blob_act()
		src.health -= 25
		if (src.health <= 0)
			visible_message("\red <B>The blob eats through the window!</B>")
			del(src)
		return

/obj/structure/barricade/window/windowless
	name = "wooden window frame"
	desc = "A wooden window frame with no glass in it. You can fit through rather easily."
	icon_state = "window_noglass"
	anchored = 1.0
	density = 0
	layer = FLY_LAYER
	health = 60

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, /obj/item/stack/sheet/glass || /obj/item/stack/sheet/rglass))
			visible_message("\red [user] begins to place the [W] in the [src]!")
			if(do_after(user,20))
				W:use(1)
				visible_message("\red [user] successfully places the [W] in the [src]!")
				new /obj/structure/barricade/window(src.loc)
		else
			..()