//Cat
/mob/living/simple_animal/rabbit
	name = "rabbit"
	desc = "The best meat around."
	icon_state = "rabbit"
	icon_living = "rabbit"
	icon_dead = "rabbit_dead"
	speak = list("Pew!","HSSSSS")
	speak_emote = list("pews")
	emote_hear = list("pews")
	emote_see = list("shakes its head", "shivers")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "kicks the"
	var/turns_since_scan = 0
	var/mob/living/simple_animal/mouse/movement_target
	min_oxy = 16 //Require atleast 16kPA oxygen
	minbodytemp = 223		//Below -50 Degrees Celcius
	maxbodytemp = 323	//Above 50 Degrees Celcius
/*
/mob/living/simple_animal/rabbit/Life()
	//MICE!
	if((src.loc) && isturf(src.loc))
		if(!stat && !resting && !buckled)
			for(var/obj/item/weapon/reagent_containers/food/snacks/grown/carrot/snack/M in view(1,src))
				del(M)
				say("Nom")
				movement_target = null
				stop_automated_movement = 0
				break

	..()

	for(var/obj/item/weapon/reagent_containers/food/snacks/grown/carrot/snack in oview(src, 7))
		if(prob(15))
			emote(pick("eyes [snack] hungrily."))
		break

	if(!stat && !resting && !buckled)
		turns_since_scan++
		if(turns_since_scan > 5)
			walk_to(src,0)
			turns_since_scan = 0
			if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))
				movement_target = null
				stop_automated_movement = 0
			if( !movement_target || !(movement_target.loc in oview(src, 7)) )
				movement_target = null
				stop_automated_movement = 0
				for(var/obj/item/weapon/reagent_containers/food/snacks/grown/carrot in oview(src,7))
					if(isturf(snack.loc))
						movement_target = snack
						break
			if(movement_target)
				stop_automated_movement = 1
				walk_to(src,movement_target,0,3)
*/