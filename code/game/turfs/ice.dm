turf/simulated/floor/plating/airless/asteroid/ice/shallow
	icon = 'icons/turf/ice.dmi'
	icon_state = "shore"
	name = "ice"
	desc = "Cold and smooth."

turf/simulated/floor/plating/airless/asteroid/ice/deep
	icon = 'icons/turf/ice.dmi'
	icon_state = "ice1"
	name = "ice"
	desc = "Cold and smooth."
	var/thickness = 3 //0 = cracked 1 = dangerously thin, 2 = normal, 3 = unbreakable
	var/hole = 0 	  // 0 = no holes, 1 = small hole for fishing, 2 = big dangerous hole

turf/simulated/floor/plating/airless/asteroid/ice/deep/New()
	icon_state = "ice[rand(1,7)]"
	thickness = rand(1,3)

turf/simulated/floor/plating/airless/asteroid/ice/deep/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (thickness == 3)
		user << "<span>\blue Ice is too thick and dense here. Try another spot...</span>"
		return

	if (istype(W, /obj/item/weapon/shovel))
		user << "<span>\blue Shovel is an inapropriate tool for that.</span>"
	if (istype(W, /obj/item/weapon/pickaxe) || istype(W, /obj/item/weapon/weldingtool))
		hole = 1
		icon_state = "hole"
		name = "ice-hole"
		user << "<span>\blue You have hacked through this ice shell. Now here is a good little ice-hole for fishing.</span>"
	if (istype(W, /obj/item/weapon/fishing_rod))
		if (hole != 0)
			user <<"<span>\blue You dip hook into ice-hole.</span>"
			var/obj/item/weapon/fishing_rod/rod
			sleep(rand(10,50)*rod.wait_time_modifier)
			var/obj/haul = pick(25*rod.carp_prob_modifier; /mob/living/simple_animal/hostile/carp,
								1; /obj/item/clothing/gloves/swat,
								1; /obj/item/device/flashlight,
								1; /obj/item/device/violin,
								1; /obj/item/weapon/broken_bottle,
								2; /obj/item/trash/candy,
								2; /obj/item/trash/syndi_cakes,
								2; /obj/item/trash/liquidfood,
								1; /obj/item/weapon/cell/crap/empty)
			if (!haul)
				haul=pick(typesof(/obj/item/weapon/reagent_containers/food/snacks/fish))
				user << "<span>\blue You have caught a [haul]! Nice one.</span>"
			else
				if (istype(haul, /mob/living/simple_animal/hostile/carp))
					user << "<span>\red [user] reels in a live carp!</span>"
				else
					user << "<span>\blue You have found... err... something...</span>"
			haul.New(user.loc)
/*			if(prob(0.30))
				user << "<span>\red [user.name] cancels fish: Interrupted by carp!</span>"
				new /mob/living/simple_animal/hostile/carp(src)
			if(prob(0.05))
				new /obj/item/clothing/gloves/fluff/chal_appara_1(user.loc)
			if(prob(0.05))
				new /obj/item/device/flashlight/fluff/thejesster14_1(user.loc)
			if(prob(0.05))
				new /obj/item/device/violin(user.loc)
			if(prob(0.05))
				new /obj/item/weapon/broken_bottle(user.loc)
			if(prob(0.10))
				new /obj/item/trash/candy(user.loc)
			if(prob(0.10))
				new /obj/item/trash/syndi_cakes(user.loc)
			if(prob(0.10))
				new /obj/item/trash/liquidfood(user.loc)
			if(prob(0.10))
				new /obj/item/trash/liquidfood(user.loc)
			if(prob(0.10))
				new /obj/item/weapon/cell/crap/empty(user.loc)*/
	else
		user << "<span>\blue You try poking ice with fishing rod, and soon you realize you need a hole in it...</span>"