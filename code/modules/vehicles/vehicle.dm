/*
This is the base file for the Artic Station Vehicle code,
Dont touch this file unless you know your shit about this.
*/

/obj/vehicle
	name = "vehicle"
	desc = "Who the hell spawned this?"
	icon = 'icons/mecha/mecha.dmi'
	icon_state = "gygax"
	density = 1 //Dense. To raise the heat.
	opacity = 0 ///Not opaque by default. horrifying..
	anchored = 1 //no pulling around.
	var/lastmove = 0
	var/list/blacklist
	var/exposed = 0 //Used for calculating attacks, whether it hits the driver/occupants
	var/occupants_max = 0 //Max occupants
	var/occupants = 0
	var/mob/living/carbon/human/driver //Driver of said vehicle, take his inputs
	var/mass = 100 // Mass of the vehicle, used for movement calculations and collision

	var/obj/item/vehicle_parts/fueltank/fueltank
	var/obj/item/vehicle_parts/propulsion/propulsion
	var/obj/item/vehicle_parts/engine/engine
	var/obj/item/vehicle_parts/chassis/chassis
	var/obj/item/vehicle_parts/seatbelt/seatbelt
	var/obj/item/vehicle_parts/armor/armor
	var/obj/item/weapon/stock_parts/cell/battery

	var/datum/action/vehicle/exit_vehicle/exit_vehicle = new


/obj/vehicle/proc/GrantActions(var/mob/living/user)
	exit_vehicle.vehicle = src
	exit_vehicle.Grant(user)

/obj/vehicle/proc/RemoveActions(var/mob/living/user)
	exit_vehicle.Remove(usr)



/obj/vehicle/proc/exit(var/atom/newloc = loc)
	RemoveActions()
	usr.forceMove(newloc)
	if(usr == driver)
		driver = null
	else
		occupants--
	usr.reset_view()

/obj/vehicle/Destroy(var/atom/newloc = loc)
	for(var/mob/M in src)
		RemoveActions(M)
		M.forceMove(newloc)
		M.reset_view()
	..()






/datum/action/vehicle
	check_flags = AB_CHECK_RESTRAINED | AB_CHECK_STUNNED | AB_CHECK_ALIVE
	action_type = AB_INNATE
	var/obj/vehicle/vehicle

/datum/action/vehicle/exit_vehicle
	name = "Eject From Mech"
	button_icon_state = "mech_eject"

/datum/action/vehicle/exit_vehicle/Activate()
	if(!owner || !iscarbon(owner))
		return
	if(!vehicle)
		return
	vehicle.exit()


/obj/vehicle/test/New()
	fueltank = new /obj/item/vehicle_parts/fueltank(src)
	propulsion = new /obj/item/vehicle_parts/propulsion(src)
	engine = new /obj/item/vehicle_parts/engine(src)
	chassis = new /obj/item/vehicle_parts/chassis(src)
	seatbelt = new /obj/item/vehicle_parts/seatbelt(src)
	battery = new /obj/item/weapon/stock_parts/cell(src)
	armor = new //obj/item/vehicle_parts/armor(src)
	update_stats()



















/obj/vehicle/proc/update_stats()
	mass = fueltank.weight + propulsion.weight + engine.weight + chassis.weight + seatbelt.weight + armor.weight //TO DO: Simplify this

/obj/vehicle/relaymove(mob/user, direction)
	if((!Process_Spacemove(direction)) || (!has_gravity(src.loc) && !propulsion.nograv))
		return
	if(!driver) //Return if no driver
		return
	if(!lastmove && user == driver)
		step(src, direction)
		lastmove = 1
		spawn(mass / engine.engine_power)
			lastmove = 0

/obj/vehicle/MouseDrop_T(mob/M, mob/user)
	if (!user.canUseTopic(src) || (user != M))
		return
	if(!ishuman(user)) // no silicons or drones in vehicles.
		return
	if(user.buckled)
		user << "<span class='warning'>You are currently buckled and cannot move.</span>"
		return
	if(occupants == occupants_max && driver)
		user << "<span class='warning'>The [src.name] is full!</span>"
		return
	for(var/mob/living/simple_animal/slime/S in range(1,user))
		if(S.Victim == user)
			user << "<span class='warning'>You're too busy getting your life sucked out of you!</span>"
			return

	visible_message("[user] starts to climb into [src.name].")

	if(do_after(user, 40, target = src))
		if(user.buckled)
			user << "<span class='warning'>You have been buckled and cannot move.</span>"
		else
			moved_inside(user)
	else
		user << "<span class='warning'>You stop entering the vehicle!</span>"
	return

/obj/vehicle/proc/moved_inside(mob/living/carbon/human/H)
	if(H && H.client && H in range(1))
		if(!driver)
			driver = H
		else if(occupants < occupants_max)
			occupants++
		H.reset_view(src)
		GrantActions(H)
		H.stop_pulling()
		H.forceMove(src)
		add_fingerprint(H)
		forceMove(loc)
		playsound(src, 'sound/machines/windowdoor.ogg', 50, 1)
		return 1
	else
		return 0