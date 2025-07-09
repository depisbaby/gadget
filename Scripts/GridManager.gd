extends Node

@export var gridBoxSpacing: int
@export var gridBoxScene: PackedScene

@onready var gridBase: Node2D = $MainGrid


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.0).timeout
	InitializeGrids()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	UpdatePointer()
	pass

func InitializeGrids():
	
	for y in 9:
		for x in 10:
			var gridBox : Node2D = gridBoxScene.instantiate()
			gridBase.add_child(gridBox)
			gridBox.position = Vector2(x*gridBoxSpacing,y*gridBoxSpacing)
			pass
			
	pass

func UpdatePointer():
	var position: Vector2 = (Global.mouseManager.GetMousePosition() - gridBase.position)/gridBoxSpacing
	
	var x: int = round(position.x)
	var y: int = round(position.y)
	#print(str(x,", ",y))
	pass

	
