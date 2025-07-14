extends Node


@onready var endingList = FinalEndingLoad.endingData

var endingId : int
var endingName : String
var endingStory : String
var endingCoverImage : String
var possibleEndings : Array[String] = []
var bag = []


func _ready() -> void:
	bag = [
		{	
			"itemId" : 3001,
			"itemCategory" :  3000,
			"itemTags" : ["defensive"],
 		},
		{
			"itemId" : 1002,
			"itemCategory" :  1000,
			"itemTags" : ["healthy food"],
 		 },
		{
			"itemId" : 2002,
			"itemCategory" :  2000,
			"itemTags" : ["attack", "sword", "jedi"],
  		},
		{
			"itemId" : 4001,
			"itemCategory" :  4000,
			"itemTags" : ["mobility, sassy"],
  		}
	]
	
	#var endingFinal = verifyEnding(bag)
	#endingId = endingFinal["endingId"]
	#endingName = endingFinal["endingName"]
	#endingStory = endingFinal["endingStory"]
	#launchCutscene()
	
	
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
				
				"itemId":
					itemIds.append(items[key])
					
				"itemCategory":
					itemCategories.append(items[key])
					
				"itemTags":
					for i in items[key]:
						itemTags.append(i)
						
	matchEnding(itemIds, itemCategories, itemTags)

	
func matchEnding(ids, categories, tags):
	print(ids)
	print(categories)
	print(tags)
	var endings = endingList
	for ending in endings: #loop through the endings
		var isEndingOk : Array[bool] = []
		print()
		print(ending)
		print()
		
		#var true_id = str(int(ending["id"])).pad_zeros(4) #USE THIS, BUT THIS IS A STRING
		#print(true_id)
		
		for conditions in ending["conditions"]:
			var count = 0
			print(conditions)

			if conditions["type"] == "category":
				if int(conditions["value"]) in categories: #needs to be int
					count = categories.count(int(conditions["value"])) #needs to be int
					var result = matchOperator(count, conditions["countType"], conditions["count"])
					
					if result == conditions["shouldBeTrue"]:
						isEndingOk.append(true)
					else:
						isEndingOk.append(false)
						
		for verifyTrue in isEndingOk:
			if verifyTrue:
				possibleEndings.append(ending["id"])

 
func matchOperator(count, type, condition):
	pass

func launchCutscene():
	pass


func _on_button_down() -> void: #button for testing, exclude afterwards
	var endingFinal = verifyEnding(bag)
	#endingId = endingFinal["endingId"]
	#endingName = endingFinal["endingName"]
	#endingStory = endingFinal["endingStory"]
	#launchCutscene()
