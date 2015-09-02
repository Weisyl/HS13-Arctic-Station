/obj/structure/railing
	desc = "A metal railing designed to cordone off areas where one may encounter open spaces."
	name = "railing"
	icon = 'icons/obj/elevator_railings.dmi'
	icon_state = "railing"		//Icons are gonna be manually selected based on instances right now until implement a feature which does it automatically. Perhaps like lattices?
	density = 1
	anchored = 1
	layer = 2.9

/obj/structure/railing/CanPass(atom/movable/mover, turf/target, height=0)
	if(height==0) return 1
	if(istype(mover, /obj/item/projectile) && density)
		return prob(10)		//Very slim chance that the projectile will hit the railing itself.
	else
		return !density