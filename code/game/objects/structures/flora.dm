/obj/structure/flora
	burn_state = 0 //Burnable
	burntime = 30

//trees
/obj/structure/flora/tree
	name = "tree"
	anchored = 1
	density = 1
	pixel_x = -16
	var/maxHealth
	var/health
	var/height = 6
	var/falling_dir = 0
	var/const/randomize_on_creation = 1
	var/const/log_type = /obj/item/weapon/grown/log/tree

/obj/structure/flora/tree/New()
	..()

	if(randomize_on_creation)
		health = rand(60, 200)
		maxHealth = health

		height = rand(3, 8)

		icon_state = pick(
		"tree_1",
		"tree_2",
		"tree_3",
		"tree_4",
		)

/obj/structure/flora/tree/New()
	maxHealth = rand(60, 200)
	health = maxHealth
	height = rand(3, 8)
	..()

/obj/structure/flora/tree/examine(mob/user)
	..()

	//Tell user about the height. Note that normally height ranges from 3 to 8 (with a 5% chance of having 6 to 15 instead)
	user << "<span class='info'>It appears to be about [height*3] feet tall.</span>"
	switch(health / maxHealth)
		if(1.0)
			//It's healthy
		if(0.9 to 0.6)
			user << "It's been partially cut down."
		if(0.6 to 0.2)
			user << "It's almost cut down, [falling_dir ? "and it's leaning towards the [dir2text(falling_dir)]." : "but it still stands upright."]"
		if(0.2 to 0)
			user << "It's going to fall down any minute now!"

/obj/structure/flora/tree/attackby(obj/item/W, mob/living/user)
	..()
	if(istype(W, /obj/item/weapon))
		if(W.sharpness == IS_SHARP) //As sharp as a knife
			if(W.w_class >= 3) //Big enough to use to cut down trees
				health -= W.force
			else
				user << "The [W] doesn't appear to be big enough to cut into \the [src]. Try something bigger."
		else
			user << "The [W] doesn't appear to be sharp enough to cut into \the [src]. Try something sharper."
	update_health()
	return 1

/obj/structure/flora/tree/proc/fall_down()
	if(!falling_dir)
		falling_dir = pick(cardinal)
	var/turf/our_turf = get_turf(src) //Turf at which this tree is located
	var/turf/current_turf = get_turf(src) //Turf in which to spawn a log. Updated in the loop
	qdel(src)
	spawn()
		while(height > 0)
			if(!current_turf) break //If the turf in which to spawn a log doesn't exist, stop the thing
			var/obj/item/I = new log_type(our_turf) //Spawn a log and throw it at the "current_turf"
			I.throw_at(current_turf, 10, 10)
			current_turf = get_step(current_turf, falling_dir)
			height--
			sleep(1)

/obj/structure/flora/tree/proc/update_health()
	if(health < 40 && !falling_dir)
		falling_dir = pick(cardinal)
		visible_message("<span class='danger'>\The [src] starts leaning to the [dir2text(falling_dir)]!</span>")
	if(health <= 0)
		fall_down()

/obj/structure/flora/tree/ex_act(severity)
	switch(severity)
		if(1) //Epicentre
			return qdel(src)
		if(2) //Major devastation
			height -= rand(1,4) //Some logs are lost
			fall_down()
		if(3) //Minor devastation (IED)
			health -= rand(10,30)
			update_health()

/obj/structure/flora/tree/pine
	name = "pine tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"

/obj/structure/flora/tree/pine/New()
	icon_state = "pine_[rand(1, 3)]"
	..()

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/tree/pine/xmas/New()
	..()
	icon_state = "pine_c"

/obj/structure/flora/tree/dead
	name = "dead tree"
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "tree_1"

/obj/structure/flora/tree/festivus
	name = "festivus pole"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "festivus_pole"
	desc = "During last year's Feats of Strength the Research Director was able to suplex this passing immobile rod into a planter."

/obj/structure/flora/tree/dead/New()
	icon_state = "tree_[rand(1, 6)]"
	..()


//grass
/obj/structure/flora/grass
	name = "grass"
	icon = 'icons/obj/flora/snowflora.dmi'
	anchored = 1
	gender = PLURAL	//"this is grass" not "this is a grass"

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/New()
	icon_state = "snowgrass[rand(1, 3)]bb"
	..()


/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/New()
	icon_state = "snowgrass[rand(1, 3)]gb"
	..()

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/New()
	icon_state = "snowgrassall[rand(1, 3)]"
	..()


//bushes
/obj/structure/flora/bush
	name = "bush"
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = 1

/obj/structure/flora/bush/New()
	icon_state = "snowbush[rand(1, 6)]"
	..()

//newbushes

/obj/structure/flora/ausbushes
	name = "bush"
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"
	anchored = 1

/obj/structure/flora/ausbushes/New()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/New()
	icon_state = "reedbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/New()
	icon_state = "leafybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/New()
	icon_state = "palebush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/New()
	icon_state = "stalkybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/New()
	icon_state = "grassybush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/New()
	icon_state = "fernybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/New()
	icon_state = "sunnybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/New()
	icon_state = "genericbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/New()
	icon_state = "pointybush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/New()
	icon_state = "lavendergrass_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/New()
	icon_state = "ywflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/New()
	icon_state = "brflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/New()
	icon_state = "ppflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/New()
	icon_state = "sparsegrass_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/New()
	icon_state = "fullgrass_[rand(1, 3)]"
	..()

/obj/structure/flora/kirbyplants
	name = "potted plant"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "plant-01"

/obj/structure/flora/kirbyplants/dead
	name = "RD's potted plant"
	desc = "A gift from the botanical staff, presented after the RD's reassignment. There's a tag on it that says \"Y'all come back now, y'hear?\"\nIt doesn't look very healthy..."
	icon_state = "plant-25"


//a rock is flora according to where the icon file is
//and now these defines
/obj/structure/flora/rock
	name = "rock"
	desc = "a rock"
	icon_state = "rock1"
	icon = 'icons/obj/flora/rocks.dmi'
	anchored = 1
	burn_state = -1 //Not Burnable

/obj/structure/flora/rock/New()
	..()
	icon_state = "rock[rand(1,5)]"

/obj/structure/flora/rock/pile
	name = "rocks"
	desc = "some rocks"
	icon_state = "rockpile1"

/obj/structure/flora/rock/pile/New()
	..()
	icon_state = "rockpile[rand(1,5)]"