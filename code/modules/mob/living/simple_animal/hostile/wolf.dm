//Wolves!
/mob/living/simple_animal/hostile/wolf
	name = "wolf"
	desc = "You should probably start running."
	icon_state = "wolf"
	icon_living = "wolf"
	icon_dead = "wolf_dead"
	icon_gib = "bee_gib"
	speak = list("GRR!","Growl!")
	speak_emote = list("growls", "roars", "howls")
	emote_hear = list("rawrs","grumbles","grawls", "howls")
	emote_see = list("glares")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	speed = 5
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	meat_amount = 2
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "hits"
	stop_automated_movement_when_pulled = 0
	maxHealth = 50
	health = 50

	melee_damage_lower = 15
	melee_damage_upper = 20
	attacktext = "claws"
	friendly = "nuzzles"

	//Immune to the cold.
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 1500

	faction = list("wolf")

/mob/living/simple_animal/hostile/bear/FindTarget()
	. = ..()
	if(.)
		emote("me", 1, "stares alertly at [.]")
		stance = HOSTILE_STANCE_ATTACK

/mob/living/simple_animal/hostile/bear/LoseTarget()
	..(5)