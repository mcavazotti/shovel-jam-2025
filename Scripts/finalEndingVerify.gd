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
	bag = [
		{
			"id": 4303,
			"category": 4000,
			"tags": ["Minecraft", "Dirt"],
		},
		{
			"id": 1001,
			"category": 1000,
			"tags": ["Fish", "Healthy", "Sea"],
		},
		{
			"id": 2002,
			"category": 2000,
			"tags": ["Head", "Stealth", "Cloak", "Elf", "Geek"],
		},
		{
			"id": 3004,
			"category": 3000,
			"tags": ["Melee", "Big", "Bronze", "Sword", "Half-blood"],
		}
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
			match key:
				
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
				intermediateEndings.append({"id" : ending["id"], "name" : ending["name"], "story" : ending["story"], "coverImage" : ending["coverImage"]})
			else:
				possibleEndings.append({"id": ending["id"], "reference": ending["reference"]})
	

func preventConflictEnding():
	var sameReference = []
	var finalEndingVerify = []
	var index: int
	
	print(possibleEndings)
	for ending in possibleEndings:
		index = sameReference.find(ending["reference"]) #search same value, always the first
		
		if index != -1:
			sameReference.remove_at(index)
			finalEndingVerify.remove_at(index)
			
		sameReference.append(ending["reference"])
		finalEndingVerify.append(ending["id"])

	var selectedEnding = finalEndingSelect(finalEndingVerify)
	
	getEndInfo(selectedEnding)
	print()
	print(endingId)
	print(endingName)
	print(endingStory)
	print(intermediateEndings)



func finalEndingSelect(endIds):
	if endIds.size() == 1:
		return endIds[0]
	#put thing that will weight out things here


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
	endingId = verifyEnding(bag)
	getEndInfo(endingId)
