extends Node


@onready var endingList = FinalEndingLoad.endingData
@onready var cutsceneControl = $"../CanvasLayer/cutsceneControl"

var endingId : int
var endingName : String
var endingStory : String
var endingCoverImage : String
var possibleEndings = []
var intermediateEndings = []
var bag = []


func _ready() -> void:
	clearEndings()
	bag = [  #FOR TESTS ONLY
		{
		"id": 1001,
		"name": "Fish",
		"category": 1000,
		"tags": ["Fish", "Healthy", "Sea"],
		"shape": [[1], [1]],
		"description": "Fish.",
		"image": "path"
	},
	{
		"id": 1002,
		"name": "Elven Bread",
		"category": 1000,
		"tags": ["Elf", "Healthy", "Bread"],
		"shape": [[1]],
		"description": "It’s said that one will keep a traveler on his feet for a day of long labour. That’s just what your child need! And you can confirm from experience what they say about this bread is true.",
		"image": "path"
	},
	{
		"id": 1003,
		"name": "Weird Fruit",
		"category": 1000,
		"tags": ["OnePiece", "Healthy", "Cursed"],
		"shape": [[1,1],[1,1]],
		"description": "You found in a chest in the closet, you remembered your husband brought from a long trip to the ocean one time, maybe your kid needs more than you.",
		"image": "path"
	},
	{
		"id": 2001,
		"name": "Stealthy Cloak",
		"category": 2000,
		"tags": ["Head", "Stealth", "Cloak"],
		"shape": [[1,1], [1,1]],
		"description": "A cloak that hides your face and gives you a mysterious and stealthy look. You remember using it when you were young.",
		"image": "path"
	},
	{
		"id": 2002,
		"name": "Elven Cloak",
		"category": 2000,
		"tags": ["Head", "Stealth", "Cloak", "Elf", "Geek"],
		"shape": [[1,1], [1,1]],
		"description": "Perfect for camouflaging against unfriendly eyes.",
		"image": "path"
	},
	{
		"id": 2101,
		"name": "Camp T-shirt",
		"category": 2000,
		"tags": ["Torso", "Camping", "T-shirt"],
		"shape": [[1,1], [1,1]],
		"description": "A T-shirt used for camping. You used to have one of it when you were young.",
		"image": "path"
	},
	{
		"id": 2102,
		"name": "Mithril Coat",
		"category": 2000,
		"tags": ["Torso", "Armor", "Dwarf", "Mithril"],
		"shape": [[1,1], [1,1]],
		"description": "A very sturdy chain mail coat. Your husband used it all the time, now it’s time for your child to use it.",
		"image": "path"
	},
	{
		"id": 2103,
		"name": "Space Monk Robe",
		"category": 2000,
		"tags": ["Torso", "Robe", "Jedi", "Geek"],
		"shape": [[1,1], [1,1], [1,1]],
		"description": "A robe worn by a specific group of space monk warriors a long time ago in a far, far away galaxy. You still wonder how your husband got his hands on that…",
		"image": "path"
	},
	{
		"id": 2201,
		"name": "Pirate Hat",
		"category": 2000,
		"tags": ["Sea", "Head"],
		"shape": [[1,1], [1,1]],
		"description": "Ahoy! Get yourself a sea-dog look!",
		"image": "path"
	},
	{
		"id": 2202,
		"name": "Bald Cap",
		"category": 2000,
		"tags": ["Head", "Disguise"],
		"shape": [[1,1], [1,1]],
		"description": "Sometimes you just want to look bald. Your husband was using it when you first met.",
		"image": "path"
	},
	{
		"id": 2203,
		"name": "Blue Helmet",
		"category": 2000,
		"tags": ["Head"],
		"shape": [[1,1,1], [1,0,1]],
		"description": "A perfect peice of armor for a knightly adventurer. Somehow, it doesn’t reveil the face at all despite the T-shaped hole in it.",
		"image": "path"
	},
	{
		"id": 3001,
		"name": "Dagger",
		"category": 3000,
		"tags": ["Melee", "Stealth", "Dagger"],
		"shape": [[1], [1]],
		"description": "A dagger that can be hidden in your clothes, good for stealth attacks. You have fond memories of it.",
		"image": "path"
	},
	{
		"id": 3002,
		"name": "Gold Sword",
		"category": 3000,
		"tags": ["Melee", "Big", "Gold", "Half-blod", "Sword"],
		"shape": [[0,1,0], [0,1,0], [0,1,0], [1,1,1], [0,1,0]],
		"description": "A big sword made of gold. Some say gold is too soft of a metal to be used to make a blade, however, you know cases when one would specifically needs a blade made of gold.",
		"image": "path"
	},
	{
		"id": 3003,
		"name": "Silver Sword",
		"category": 3000,
		"tags": ["Melee", "Big", "Silver", "Sword"],
		"shape": [[0,1,0], [0,1,0], [0,1,0], [1,1,1], [0,1,0]],
		"description": "A big sword made of silver. You don’t know how different it is from a regular sword, but your husband did know.",
		"image": "path"
	},
	{
		"id": 3004,
		"name": "Bronze Sword",
		"category": 3000,
		"tags": ["Melee", "Big", "Bronze", "Sword", "Half-blood"],
		"shape": [[0,1,0], [0,1,0], [0,1,0], [1,1,1], [0,1,0]],
		"description": "A big sword made of bronze. Ancient warriors used bronze weapons. Some young people nowadays still use them, you think to yourself.",
		"image": "path"
	},
	{
		"id": 3005,
		"name": "Steel Sword",
		"category": 3000,
		"tags": ["Melee", "Big", "Steel", "Sword"],
		"shape": [[0,1,0], [0,1,0], [0,1,0], [1,1,1], [0,1,0]],
		"description": "A big sword made of steel. Just a regular sword.",
		"image": "path"
	},
	{
		"id": 3006,
		"name": "Elven Short Sword",
		"category": 3000,
		"tags": ["Melee", "Elf", "Sword"],
		"shape": [[0,1,0], [0,1,0], [1,1,1], [0,1,0]],
		"description": "A small sword from very ancient times. Your husband found it during one of his trips.",
		"image": "path"
	},
	{
		"id": 3007,
		"name": "Retractable Light Sword",
		"category": 3000,
		"tags": ["Melee", "Jedi", "Sword", "Geek"],
		"shape": [[1], [1], [1]],
		"description": "It’s very handy to have a retractable sword that defies laws of physics and can cut through reinforced steel instantly! You still wonder where your husband found it…",
		"image": "path"
	},
	{
		"id": 3008,
		"name": "Pistol with Silencer",
		"category": 3000,
		"tags": ["Ranged", "Stealth", "Spy", "Pistol"],
		"shape": [[1,1,1], [1,0,0]],
		"description": "A Pistol with silencer from your husband stuff, you don’t know much why he has it, but you know it was a gift from a friend.",
		"image": "path"
	},
	{
		"id": 3009,
		"name": "Blue Spade",
		"category": 3000,
		"tags": ["Big", "Melee"],
		"shape": [[1,1,1], [1,1,1], [0,1,0], [1,1,1], [0,1,0]],
		"description": "A long, trusty blue shovel. It’s seen countless battles against knights. According to your husband, he also used to have a red sheild, however he didn’t have enough space in his bag to bring it home.",
		"image": "path"
	},
	{
		"id": 4001,
		"name": "Medallion",
		"category": 4000,
		"tags": ["Necklace"],
		"shape": [[1]],
		"description": "It might be magic, it might be cursed, or it might be just a regular medallion, you don’t know. All you know is that your husband brought it home after a trip.",
		"image": "path"
	},
	{
		"id": 4002,
		"name": "Invisibility ring",
		"category": 4000,
		"tags": ["Ring", "Gold"],
		"shape": [[1]],
		"description": "A golden ring that turns the wearer invisible. It might do other things too, but you’re not sure. Your husband got it after a game of riddles in the dark.",
		"image": "path"
	},
	{
		"id": 4101,
		"name": "Broken Elven Sword",
		"category": 4000,
		"tags": ["Elf"],
		"shape": [[0,1,0], [1,1,1], [0,1,0]],
		"description": "An ancient sword, or at least what remains of it, which is not really useful by itself. Your husband received it as an inheritance.",
		"image": "path"
	},
	{
		"id": 4102,
		"name": "Broken Elven Blade",
		"category": 4000,
		"tags": ["Elf"],
		"shape": [[1], [1]],
		"description": "Part of the blade of an ancient sword. Not really useful by itself. Your husband received it as an inheritance.",
		"image": "path"
	},
	{
		"id": 4103,
		"name": "Broken Elven Blade",
		"category": 4000,
		"tags": ["Elf"],
		"shape": [[1], [1]],
		"description": "Part of the blade of an ancient sword. Not really useful by itself. Your husband received it as an inheritance.",
		"image": "path"
	},
	{
		"id": 4104,
		"name": "Broken Elven Tip",
		"category": 4000,
		"tags": ["Elf"],
		"shape": [[1]],
		"description": "Part of the blade of an ancient sword. Not really useful by itself. Your husband received it as an inheritance.",
		"image": "path"
	},
	{
		"id": 4201,
		"name": "Picture with best friend",
		"category": 4000,
		"tags": ["Memory", "Friend", "Relationship", "Paper"],
		"shape": [[1,1]],
		"description": "It’s good to remember people who are important to us. It might be useful for your child during his adventure.",
		"image": "path"
	},
	{
		"id": 4202,
		"name": "Letter of a loved one",
		"category": 4000,
		"tags": ["Memory", "Love", "Relationship", "Paper"],
		"shape": [[1,1]],
		"description": "It’s good to remember people who are important to us. It might be useful for your child during his adventure.",
		"image": "path"
	},
	{
		"id": 4203,
		"name": "The Chosen One certificate",
		"category": 4000,
		"tags": ["Certificate", "Paper"],
		"shape": [[1,1]],
		"description": "Everyone should know that your child is the chosen one!",
		"image": "path"
	},
	{
		"id": 4204,
		"name": "Unknown Father certificateate",
		"category": 4000,
		"tags": ["Certificate", "Paper"],
		"shape": [[1,1]],
		"description": "Everyone should know that your child doesn’t know who his father is.",
		"image": "path"
	},
	{
		"id": 4205,
		"name": "Machinery for Dummies",
		"category": 4000,
		"tags": ["Book", "Paper"],
		"shape": [[1], [1]],
		"description": "Very useful in case your child has to build something.",
		"image": "path"
	},
	{
		"id": 4206,
		"name": "Piloting for Dummies",
		"category": 4000,
		"tags": ["Book", "Paper"],
		"shape": [[1], [1]],
		"description": "Very useful in case your child has to pilot something.",
		"image": "path"
	},
	{
		"id": 4207,
		"name": "Alchemy for Dummies",
		"category": 4000,
		"tags": ["Book", "Paper"],
		"shape": [[1], [1]],
		"description": "Very useful if your child has to brew something or do some chemical reactions.",
		"image": "path"
	},
	{
		"id": 4208,
		"name": "Map",
		"category": 4000,
		"tags": ["Localization", "Paper"],
		"shape": [[1,1], [1,1]],
		"description": "People say that maps are a thing from the past, but you’re a mom, you know better.",
		"image": "path"
	},
	{
		"id": 4209,
		"name": "License to Kill",
		"category": 4000,
		"tags": ["Certificate", "Paper", "Spy"],
		"shape": [[1,1]],
		"description": "You really dont know how and why there’s this kind of license with your child’s name, but it could be handy.",
		"image": "path"
	},
	{
		"id": 4301,
		"name": "GPS",
		"category": 4000,
		"tags": ["Localization", "Eletronics"],
		"shape": [[1]],
		"description": "Let’s make use of what technology gives us! Your child will never get lost with this device!",
		"image": "path"
	},
	{
		"id": 4302,
		"name": "RV Trailer keys",
		"category": 4000,
		"tags": ["Vehicle"],
		"shape": [[1]],
		"description": "Trailers are the best: the speed of a car with the comfort of a home!",
		"image": "path"
	},
	{
		"id": 4303,
		"name": "Dirt Cube",
		"category": 4000,
		"tags": ["Dirt"],
		"shape": [[1]],
		"description": "Why is there dirt in the house?! Was it meant for a plant? There is no pot. Maybe your child deserves a dirty bag as retribution for bringing this inside. There is no way your husband would bring just dirt inside.",
		"image": "path"
	},
	]
	
	var finalId = verifyEnding()
	getEndInfo(finalId)
	launchCutscene()


func verifyEnding():
	if not bag:
		return 0001
		
	var itemIds : Array[int] = []
	var itemCategories : Array[int] = []
	var itemTags : Array[String] = []
	
	for items in bag:
		for key in items.keys():
			match key: #CHANGE KEYS TO MATCH KEYS IN BAG
				
				"id":
					itemIds.append(items[key])
					
				"category":
					itemCategories.append(items[key])
					
				"tags":
					for i in items[key]: #i being the items in the Tags array.
						itemTags.append(i)
						
	matchEnding(itemIds, itemCategories, itemTags)
	preventConflictEnding()
	

func matchEnding(ids, categories, tags):
	var endings = endingList
	for ending in endings: #loop through the endings
		var isEndingOk : Array[bool] = []
		
		#var true_id = str(int(ending["id"])).pad_zeros(4) #USE THIS, BUT THIS IS A STRING
		for conditions in ending["conditions"]:
			var count = 0	
			var c = conditions["type"]
			var value = conditions["value"]
			
			match c: 
				"category":
					if int(value) in categories: 
						count = categories.count(int(value))
						
				"id":	
					if int(value) in ids: 
						count = ids.count(int(value))
						
				"tag":	
					if value in tags: 
						count = tags.count(value)
									
			var result = matchOperator(count, conditions["countType"], conditions["count"])
			if result == conditions["shouldBeTrue"]: 
				isEndingOk.append(true)
			else:
				isEndingOk.append(false)	
										
											
		if not isEndingOk.has(false):
			if ending["typeOfEnding"] == "Intermediate":
				intermediateEndings.append({"id" : ending["id"], "name" : ending["name"], "story" : ending["story"]})
			else:
				possibleEndings.append({"id": ending["id"], "reference": ending["reference"], "conditions" : ending["conditions"]})
	

func preventConflictEnding():
	var sameReference = []
	var finalEndingVerify = []
	var endingConditions = []
	var index: int
	
	for ending in possibleEndings:
		index = sameReference.find(ending["reference"]) #search same value, always the first
		
		if index != -1:
			sameReference.remove_at(index)
			finalEndingVerify.remove_at(index)
			
		sameReference.append(ending["reference"])
		finalEndingVerify.append(ending["id"])
		endingConditions.append(ending["conditions"])

	var selectedEnding = finalEndingSelect(finalEndingVerify, endingConditions)
	getEndInfo(selectedEnding)


func finalEndingSelect(endIds, conditionsArray):
	var biggest_index = -1
	var biggest_size = -1
	
	if endIds.size() == 1:
		return endIds[0]
	else:
		for i in range(endIds.size()):
			if int(endIds[i]) == 0:
				continue
			var conditions = conditionsArray[i]
			if conditions.size() > biggest_size:
				biggest_size = conditions.size()
				biggest_index = i
				
				
	return endIds[biggest_index]
	

func getEndInfo(id):
	var endings = endingList
	for ending in endings:	
		if ending["id"] == id:
			endingId = ending["id"]
			endingName = ending["name"]
			endingStory = ending["story"]
			endingCoverImage = ending["coverImage"]


func matchOperator(count, type, condition):
	match type:
		"==": 
			return count == condition
		">=":
			return count >= condition
		"!=":
			return count != condition
		"<=":
			return count <= condition
		">":
			return count > condition
		"<":
			return count > condition


func launchCutscene():
	if cutsceneControl:
		cutsceneControl.finalEnding = {
			"id": endingId,
			"name": endingName,
			"story": endingStory,
			"coverImage": endingCoverImage
		}
		cutsceneControl.intermediateEndings = intermediateEndings
		cutsceneControl.treatEnding()

func clearEndings():
	endingId = 0
	endingName = ""
	endingStory = ""
	endingCoverImage = ""
	possibleEndings = [] 
	intermediateEndings = [] 
	
