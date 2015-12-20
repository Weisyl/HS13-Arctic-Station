/obj/item/vehicle_parts
	name = "vehicle part"
	icon = 'icons/mecha/mech_construct.dmi'
	icon_state = "blank"
	w_class = 4  //Will vary between parts
	flags = CONDUCT
	origin_tech = "programming=2;materials=2"
	var/durability = 100 //Durability of the part
	var/weight = 10 //Mass of part

/obj/item/vehicle_parts/engine
	var/engine_power = 100 //Engine power, used to calculate the delay between movement
	var/fuel_consumption = 1



/obj/item/vehicle_parts/propulsion
	var/thrust_type = "rolling" //Will look into this later
	var/nograv = 0 //Can it function with no gravity?
	weight = 0 //Typically has no weight as it's SUPPORTING the chassis


/obj/item/vehicle_parts/fueltank
	var/fuel_capacity = 100//How much fuel the tank can hold
	var/fuel_amount = 0 //How much fuel it actually has


/obj/item/vehicle_parts/chassis
	var/max_mass = 200
	var/occupants_max = 2

/obj/item/vehicle_parts/armor
	weight = 100
	//(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0) Armor value positions
	armor = list(0,0,0,0,0,0,0)//Damage reduction based on armor

/obj/item/vehicle_parts/seatbelt
	weight = 0

