/turf/unsimulated/floor
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "floor"

/turf/unsimulated/floor/plating
	name = "plating"
	icon_state = "plating"
	intact = 0

/turf/unsimulated/floor/bluegrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"

/turf/unsimulated/floor/engine
	icon_state = "engine"

/turf/unsimulated/floor/attack_paw(user as mob)
	return src.attack_hand(user)

/turf/unsimulated/floor/abductor
	name = "alien floor"
	icon_state = "alienpod1"

/turf/unsimulated/floor/abductor/New()
	..()
	icon_state = "alienpod[rand(1,9)]"

/turf/unsimulated/floor/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	temperature = T0C
	thermal_conductivity = OPEN_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 700000

/turf/unsimulated/floor/snow/New()
	icon_state = "snow[rand(1, 7)]"
	..()

turf/unsimulated/floor/snow/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/shovel))
		if(!user.IsAdvancedToolUser())
			user << "\red you don't know how to use this [W.name]"
			return
		var/footprints = 0
		usr << "\blue you start shoveling"
		if(do_after(user,20))
			for(var/obj/effect/footprint/footprint in src)
				del(footprint)
				footprints = 1
			if(isturf(user.loc))
				for(var/obj/effect/footprint/footprint in user.loc)
					del(footprint)
					footprints = 1
			if(footprints)
				usr << "\blue You cover up the footprints"


/turf/unsimulated/floor/snow/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			user << "<span class='warning'>There is already a lattice.</span>"
			return
		if(R.use(1))
			user << "<span class='notice'>Constructing support lattice...</span>"
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			ReplaceWithLattice()
		else
			user << "<span class='warning'>You need one rod to build lattice.</span>"
		return
	if(istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
				user << "<span class='notice'>You build a floor.</span>"
				ChangeTurf(/turf/simulated/floor/plating)
			else
				user << "<span class='warning'>You need one floor tile to build a floor.</span>"
		else
			user << "<span class='danger'>The plating is going to need some support. Place metal rods first.</span>"