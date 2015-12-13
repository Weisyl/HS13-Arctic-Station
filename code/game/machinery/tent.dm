/obj/machinery/tent
	name = "tent"
	icon = 'icons/obj/objects.dmi'
	icon_state = "free"
	density = 1
	anchored = 1
	layer = 2.8

	var/temperature_archived = 293.15
	var/mob/living/carbon/occupant = null


/obj/machinery/tent/New()
	..()
//	initialize_directions = dir


/obj/machinery/tent/process()
	..()
	if(occupant)
		if(occupant.stat != 2)
			process_occupant()
	updateUsrDialog()
	return 1

/*
/obj/machinery/tent/allow_drop()
	return 0
*/

/obj/machinery/tent/relaymove(mob/user as mob)
	if(user.stat)
		return
	go_out()
	return

/obj/machinery/tent/attackby(var/obj/item/weapon/G as obj, var/mob/user as mob)
	if(istype(G, /obj/item/weapon/grab))
		if(!ismob(G:affecting))
			return
		for(var/mob/living/carbon/slime/M in range(1,G:affecting))
			if(M.Victim == G:affecting)
				usr << "[G:affecting:name] will not fit into the tent because they have a slime latched onto their head."
				return
		var/mob/M = G:affecting
		if(put_mob(M))
			del(G)
	updateUsrDialog()
	return

/obj/machinery/tent/update_icon()
	if(occupant)
		icon_state = "occupied"
		return
	icon_state = "free"

/obj/machinery/tent/proc/process_occupant()
	if(occupant)
		if(occupant.stat == 2)
			return
		if (occupant.bodytemperature < temperature_archived)
			occupant.bodytemperature += 25
			occupant.bodytemperature = max(occupant.bodytemperature, temperature_archived)
			if(occupant.getOxyLoss()) occupant.adjustOxyLoss(-1)
			var/heal_fire = occupant.getFireLoss() ? min(1, 20/occupant.getFireLoss()) : 0
			occupant.heal_organ_damage(heal_fire)
			occupant.stat = 1

/obj/machinery/tent/proc/go_out()
	if(!( occupant ))
		return
	//for(var/obj/O in src)
	//	O.loc = loc
	if (occupant.client)
		occupant.client.eye = occupant.client.mob
		occupant.client.perspective = MOB_PERSPECTIVE
	occupant.loc = src.loc	//this doesn't account for walls or anything, but i don't forsee that being a problem.
	if (occupant.bodytemperature < 261 && occupant.bodytemperature > 140) //Patch by Aranclanos to stop people from taking burn damage after being ejected
		occupant.bodytemperature = 261
//	occupant.metabslow = 0
	occupant = null
	update_icon()
	return
/obj/machinery/tent/proc/put_mob(mob/living/carbon/M as mob)
	if (!istype(M))
		usr << "\red <B>This tent cannot handle such liveform!</B>"
		return
	if (occupant)
		usr << "\red <B>Tent is already occupied!</B>"
		return
	if (M.client)
		M.client.perspective = EYE_PERSPECTIVE
		M.client.eye = src
	M.stop_pulling()
	M.loc = src
	if(M.health > -100 && (M.health < 0 || M.sleeping))
		M << "\blue <b>You feel a warw air surround you.</b>"
	occupant = M
//	M.metabslow = 1
	add_fingerprint(usr)
	update_icon()
	return 1

/obj/machinery/tent/verb/move_eject()
	set name = "Eject occupant"
	set category = "Object"
	set src in oview(1)
	if(usr == occupant)//If the user is inside the tube...
		if (usr.stat == 2)//and he's not dead....
			return
		usr << "\blue Release sequence activated. This will take some time."
		sleep(150)
		if(!src || !usr || !occupant || (occupant != usr)) //Check if someone's released/replaced/bombed him already
			return
		go_out()//and release him from the eternal prison.
	else
		if (usr.stat != 0)
			return
		go_out()
	add_fingerprint(usr)
	return

/obj/machinery/tent/verb/move_inside()
	set name = "Move Inside"
	set category = "Object"
	set src in oview(1)
	for(var/mob/living/carbon/slime/M in range(1,usr))
		if(M.Victim == usr)
			usr << "You're too busy getting your life sucked out of you."
			return
	if (usr.stat != 0 || stat & (NOPOWER|BROKEN))
		return
	put_mob(usr)
	return

/obj/machinery/tent/attack_hand(mob/living/user as mob)
	if(!occupant)
		new /obj/item/weapon/tent(user.loc)
		src.Del()
	else
		usr << "\red <B>Tent is already occupied!</B>"
/obj/item/weapon/tent
	name = "tent"
	icon = 'icons/obj/items.dmi'
	icon_state = "tent"
	desc = "Serves as acceptale shelter when deployed."

/obj/item/weapon/tent/attack_self(mob/living/user)
	new /obj/machinery/tent(user.loc)
	src.Del()

/obj/machinery/campfire
	name = "campfire"
	icon = 'code/WorkInProgress/Cael_Aislinn/Jungle/jungle.dmi'
	icon_state = "campfire_n"
	density = 0
	anchored = 1
	layer = 2.8
	var/firing = 0

/obj/machinery/campfire/New()
	..()
//	initialize_directions = dir


/obj/machinery/campfire/process()
	..()
	if(firing)
		process_campfire()
	updateUsrDialog()
	return 1

/obj/machinery/campfire/update_icon()
	if(firing)
		icon_state = "campfire"
		luminosity = 4
		return
	icon_state = "campfire_n"
	luminosity = 0

/obj/machinery/campfire/attack_hand(mob/living/user as mob)
	if (usr.stat != 0)
		return
	firing=!firing
	update_icon()
	return

/obj/machinery/campfire/proc/process_campfire()
	if(firing)
		for(var/mob/living/carbon/C in range(2,src))
			if (C.bodytemperature < 290)
				C.bodytemperature = 290
