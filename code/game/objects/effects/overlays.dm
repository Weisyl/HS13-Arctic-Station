/obj/effect/overlay
	name = "overlay"
	unacidable = 1
	var/i_attached//Added for possible image attachments to objects. For hallucinations and the like.

/obj/effect/overlay/singularity_act()
	return

/obj/effect/overlay/singularity_pull()
	return

/obj/effect/overlay/beam//Not actually a projectile, just an effect.
	name="beam"
	icon='icons/effects/beam.dmi'
	icon_state="b_beam"
	var/atom/BeamSource

/obj/effect/overlay/beam/New()
	..()
	spawn(10) qdel(src)

/obj/effect/overlay/palmtree_r
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm1"
	density = 1
	layer = 5
	anchored = 1

/obj/effect/overlay/palmtree_l
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm2"
	density = 1
	layer = 5
	anchored = 1

/obj/effect/overlay/coconut
	name = "Coconuts"
	icon = 'icons/misc/beach.dmi'
	icon_state = "coconuts"
/*
/obj/effect/snow_covering
	icon = 'icons/turf/overlays.dmi'
	icon_state = "snowwall"
	layer = TURF_LAYER + 0.1

		for(var/turf/simulated/floor/plating/snow in range(src,1))
		var/snowDirection = get_dir(src,snowTile)
		if(snowDirection in cardinal)
			new /obj/effect/snow_covering(snowTile,snowDirection)

	New(turf/location, direction)
		..()

		dir = direction

		switch(dir)
			if(NORTH)
				pixel_y -= 5
			if(SOUTH)
				pixel_y += 5
			if(EAST)
				pixel_x -= 6
			if(WEST)
				pixel_x += 5
*/