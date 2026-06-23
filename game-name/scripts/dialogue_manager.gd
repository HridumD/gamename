extends Node

# Uninitialized Variables (Editable in Editor)
@export var dialogue_lines: String
@export var delay: float

# Actual text to be displayed
var RTL: RichTextLabel

# Start function (Called once at start)
func _ready() -> void:
	RTL = self.get_child(1)
	
	RTL.text = dialogue_lines
	
	typeDialogue(delay, dialogue_lines, RTL)

# Update function (Called every frame) -> (Delta is essentially time passed since last frame)
func _process(delta: float) -> void:
	pass
	
# Type dialogue function
func typeDialogue(delay: float, dialogue: String, RTL: RichTextLabel) -> void:
	# Make text invisible first
	RTL.visible_characters = 0
	
	# Get max character length of dialogue and make tracker variable
	var max_characters = dialogue.length()
	var current_characters = 0
	
	# Type dialogue with delay
	while current_characters < max_characters:
		await get_tree().create_timer(delay).timeout
		current_characters+=1
		RTL.visible_characters = current_characters
		
