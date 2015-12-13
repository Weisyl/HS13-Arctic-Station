/obj/item/weapon/fishing_rod
	name = "fishing rod"
	desc = "A simple fishing rod may provide you a luxirious diner. Âut only if you will be able to find a pond without human eating species."
	icon = 'icons/obj/fishing.dmi'
	icon_state = "rod"
	w_class = 3.0
	var wait_time_modifier = 1.0
	var carp_prob_modifier = 1.0
	var obj/item/weapon/reagent_containers/food/snacks/bait
	var possible_catch

/obj/item/weapon/fishing_rod/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (!istype(W, /obj/item/weapon/reagent_containers/food/snacks))
		user << "<span>\blue This doesen't look like a good bait...</span>"
	else
		bait = W
		if (/datum/reagent/nutriment in bait.reagents)
			var/datum/reagent/nutriment/nut = bait.reagents["nutriment"]
			wait_time_modifier /= nut.volume
		if (istype(bait, /obj/item/weapon/reagent_containers/food/snacks/meat/human))
			carp_prob_modifier *=3
		user << "<span>\blue You put the [bait] on the hook.</span>"

/obj/item/weapon/fishing_rod/attack_self(mob/user)
	if (bait)
		usr.put_in_hands(bait)
		user << "<span>\blue You take off some bait from the hook.</span>"
	else
		user << "<span>\blue There is no bait.</span>"

/mob/living/simple_animal/hostile/carp/polar
	icon = 'icons/obj/fishing.dmi'
	name = "brawler carp"
	icon_state = "brawler_carp"
	desc = "A vicious hybrid of terran carp and local predatory dipnoi."
	speed = 3

/obj/item/weapon/reagent_containers/food/snacks/fish
	icon = 'icons/obj/fishing.dmi'

/obj/item/weapon/reagent_containers/food/snacks/fish/sushi_fish
	name = "sushi fish"
	desc = "Small, meaty fish. Can be eaten raw."
	icon_state = "sushi-fish"
	bitesize = 1
	slices_num = 2
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/sushi_fish
	New()
		..()
		reagents.add_reagent("nutriment", 4)

/obj/item/weapon/reagent_containers/food/snacks/fish/catfish
	name = "catfish"
	desc = "Large terran fish with gorgeous moustaches!"
	icon_state = "catfish"
	bitesize = 4
	slices_num = 4
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/catfish
	New()
		..()
		reagents.add_reagent("nutriment", 12)

/obj/item/weapon/reagent_containers/food/snacks/fish/carp
	name = "carp"
	desc = "Moist and delicious! Terran origin."
	icon_state = "carp"
	bitesize = 4
	slices_num = 4
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/carp
	New()
		..()
		reagents.add_reagent("nutriment", 16)

/obj/item/weapon/reagent_containers/food/snacks/fish/perch
	name = "perch"
	desc = "Medium-sized fish from Terra."
	icon_state = "perch"
	bitesize = 2
	slices_num = 3
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/perch
	New()
		..()
		reagents.add_reagent("nutriment", 3)

/obj/item/weapon/reagent_containers/food/snacks/fish/sprattus
	name = "sprattus"
	desc = "Tiny little fish from Terra. More like snack for beer than sterling dish."
	icon_state = "sprattus"
	bitesize = 1
	slices_num = 1
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/sprattus
	New()
		..()
		reagents.add_reagent("nutriment", 1)

/obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/sushi_fish
	name = "sushi fish fillet"
	desc = "Fresh!"
	icon_state = "sushi_meat"
	bitesize = 1
	New()
		..()
		reagents.add_reagent("nutriment", 2)

/obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/catfish
	name = "catfish fillet"
	desc = "Fresh and smells like river water."
	icon_state = "catfish_meat"
	bitesize = 1
	New()
		..()
		reagents.add_reagent("nutriment", 3)

/obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/carp
	name = "carp fillet"
	desc = "Fatty and nutritious."
	icon_state = "carp_meat"
	bitesize = 1
	New()
		..()
		reagents.add_reagent("nutriment", 4)

/obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/perch
	name = "perch fillet"
	desc = "Dietetic and mostly without bones!"
	icon_state = "perch_meat"
	bitesize = 1
	New()
		..()
		reagents.add_reagent("nutriment", 1)

/obj/item/weapon/reagent_containers/food/snacks/fish_meat/fish/sprattus
	name = "sprattus fillet"
	desc = "Why even somebody wanted to butcher sprattus? You can devour it in one bite!"
	icon_state = "sprattus_meat"
	bitesize = 1
	New()
		..()
		reagents.add_reagent("nutriment", 1)


