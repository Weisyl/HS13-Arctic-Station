/obj/structure/woodenwalls
	name = "wooden wall"
	desc = "Nash sovietsky soyuz pokaraet ves mir ot Evropi, k Neve na vostok, nad zemley vezde budut pet: Stolica, vodka, sovtskiy medved nash!."
	icon = 'icons/obj/wood_house.dmi'
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
		if (istype(O, /obj/item/stack/material/wood))
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
				if("fire")
					src.health -= O.force * 1
				if("brute")
					src.health -= O.force * 0.75
				else
			if (src.health <= 0)
				visible_message("\red <B>The wall is smashed apart!</B>")
				new /obj/item/stack/material/wood(get_turf(src))
				new /obj/item/stack/material/wood(get_turf(src))
				new /obj/item/stack/material/wood(get_turf(src))
				temploc = src.loc
				spawn(10)
				for(var/obj/structure/woodenwalls/W in range(temploc,1))
					W.relativewall()
				relativewall_neighbours()
				del(src)
			..()

/obj/structure/woodenwalls/New()
	relativewall_neighbours()
	..()

/obj/structure/woodenwalls/Del()

	temploc = src.loc

	spawn(10)
		for(var/obj/structure/woodenwalls/W in range(temploc,1))
			W.relativewall()
	relativewall_neighbours()
	..()


/obj/structure/woodenwalls/proc/relativewall()

	var/junction = 0 //will be used to determine from which side the wall is connected to other walls

	for(var/obj/structure/woodenwalls/W in orange(src,1))
		if(abs(src.x-W.x)-abs(src.y-W.y)) //doesn't count diagonal walls
			if(src.mineral == W.mineral)
				junction |= get_dir(src,W)
	icon_state = "[mineral][junction]"
	return


/obj/structure/woodenwalls/proc/relativewall_neighbours()
	for(var/obj/structure/woodenwalls/S in range(src,1))
		S.relativewall()
		S.update_icon()
	return

/obj/structure/woodenwalls/update_icon()//Calling icon_update will refresh the smoothwalls if it's closed, otherwise it will make sure the icon is correct if it's open
	..()
	icon_state = "[mineral]0"
	src.relativewall()

/obj/structure/woodfloor
	name = "wooden floor"
	icon = 'icons/obj/wood_house.dmi'
	icon_state = "floor"
	density = 0
	anchored = 1
	layer = 2.05

/obj/structure/woodfloor/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if( istype(W, /obj/item/weapon/crowbar) )
		new /obj/item/stack/material/wood(get_turf(src))
		new /obj/item/stack/material/wood(get_turf(src))
		del(src)

/obj/structure/barricade/window
	name = "wooden window"
	desc = "Russian style."
	icon = 'icons/obj/wood_house.dmi'
	icon_state = "window"
	anchored = 1.0
	density = 1.0
	layer = FLY_LAYER
	health = 100.0
	maxhealth = 100.0

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, /obj/item/stack/material/wood))
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
				if("fire")
					src.health -= W.force * 1
				if("brute")
					src.health -= W.force * 0.75
				else
			if (src.health <= 0)
				visible_message("\red <B>The window is smashed apart!</B>")
				new /obj/item/stack/material/wood(get_turf(src))
				new /obj/item/stack/material/wood(get_turf(src))
				new /obj/item/stack/material/wood(get_turf(src))
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
					new /obj/item/stack/material/wood(get_turf(src))
					new /obj/item/stack/material/wood(get_turf(src))
					new /obj/item/stack/material/wood(get_turf(src))
					del(src)
				return

	meteorhit()
		visible_message("\red <B>The window is smashed apart!</B>")
		new /obj/item/stack/material/wood(get_turf(src))
		new /obj/item/stack/material/wood(get_turf(src))
		new /obj/item/stack/material/wood(get_turf(src))
		del(src)
		return

	blob_act()
		src.health -= 25
		if (src.health <= 0)
			visible_message("\red <B>The blob eats through the window!</B>")
			del(src)
		return