extends Node


@onready var endingList = FinalEndingLoad.endingData

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
		"id": 1002,
		"name": "Elven Bread",
		"category": 1000,
		"tags": ["Elf", "Healthy", "Bread"],
		"shape": [[1]],
		"description": "It’s said that one will keep a traveler on his feet for a day of long labour. That’s just what your child need! And you can confirm from experience what they say about this bread is true.",
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
	]
	
	#launchCutscene()
	#var endingId = verifyEnding(bag)
	#getEndInfo(endingId)


func verifyEnding(bag):
	if not bag:
		print("empty")
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
	
	print(endingId)
	print(endingName)
	print(endingStory)
	print(endingCoverImage)
	

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
				intermediateEndings.append({"id" : ending["id"], "name" : ending["name"], "story" : ending["story"], "coverImage" : ending["coverImage"]})
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
	print(endIds)
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
			endingId = id
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
	pass


func clearEndings():
	endingId = 0
	endingName = ""
	endingStory = ""
	endingCoverImage = ""
	possibleEndings = [] 
	intermediateEndings = [] 


func _on_button_down() -> void:  #REMOVE IN FINAL VERSION, will be
	clearEndings()
	var endingId = verifyEnding(bag)
	getEndInfo(endingId)
