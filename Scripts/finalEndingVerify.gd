extends Node


@onready var endingList = FinalEndingLoad.endingData
@onready var cutsceneControl = $"../CanvasLayer/cutsceneControl"

var endingId : int
var endingName : String
var endingStory : String
var endingCoverImage : String
var possibleEndings = []
var intermediateEndings = []
var itemsBackpack


func _ready() -> void:
	itemsBackpack = FinalEndingLoad.itemsBackpack
	clearEndings()
	
	var finalId = verifyEnding()
	print(finalId)
	getEndInfo(finalId)
	launchCutscene()


func verifyEnding():
	if not itemsBackpack:
		return 0001
	print(itemsBackpack)
	var itemIds : Array[int] = []
	var itemCategories : Array[int] = []
	var itemTags : Array[String] = []
	
	for items in itemsBackpack:
		for key in items.keys():
			match key: #CHANGE KEYS TO MATCH KEYS IN BAG
				
				"Id":
					itemIds.append(items[key])
					
				"Category":
					itemCategories.append(items[key])
					
				"Tags":
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
	
	print(endIds)
	
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

	if endIds:
		return endIds[biggest_index]
	return 0000 #Default Ending
	

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
	
