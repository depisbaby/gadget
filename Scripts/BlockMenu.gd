extends Node
class_name BlockMenu

@export var blocksPackedScenes : Array[PackedScene] = [
	preload("res://Scenes/Blocks/block_alpha.tscn"),
	preload("res://Scenes/Blocks/block_beta.tscn"),
	preload("res://Scenes/Blocks/block_delta.tscn")
]
var blockLibrary : Array[Block]
var menuItemPackedScene : PackedScene = preload("res://Scenes/block_menu_item.tscn")
@onready var base: Control = $Base
@onready var scrollMenuBase : Control = $Base/ScrollMenuBase
var open : bool = false
var menuItems: Array[BlockMenuItem]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	await get_tree().create_timer(1.0).timeout
	
	#initialize block library
	for i in blocksPackedScenes:
		var block :Block = i.instantiate()
		blockLibrary.push_back(i)
	
	AddBlockToMenu("alpha", 3)
	AddBlockToMenu("beta", 5)
	AddBlockToMenu("delta", 7)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#menu movement
	if open:
		base.position = lerp(base.position, Vector2(755,0), delta*10)
		pass
	else:
		base.position = lerp(base.position, Vector2(1157,0), delta*10)
		pass
		
	pass


func _on_button_open_pressed():
	UpdateBlockMenu()
	open = !open
	pass # Replace with function body.

func AddBlockToMenu(name: String, amount:int):
	#check that block of that name exists
	var foundBlock : Block
	for i in blockLibrary:
		if i.blockName == name:
			foundBlock = i
	
	if foundBlock == null:
		print("Block not found")
		return
	
	# check if item already in the menu	and add amount
	for i in menuItems:
		if i.itemName == name:
			i.amount = i.amount + amount
			UpdateBlockMenu()
			return 
	
	#create new
	var menuItem : BlockMenuItem = menuItemPackedScene.instantiate()
	scrollMenuBase.add_child(menuItem)
	menuItem.name = name
	menuItem.amount = amount
	menuItem.texture = foundBlock.texture
	menuItems.push_back(menuItem)
	print("Added block")
	UpdateBlockMenu()
		
	pass


func UpdateBlockMenu(): #updates the menu
	var x:int
	var y: int
	var spacing: int = 32
	for i in menuItems:
		i.position = scrollMenuBase.position + Vector2(x*spacing, y*spacing)
		x = x + 1
		if x == 2:
			x = 0
			y = y + 1
		
		
		
	pass
