extends Node

# Uninitialized Variables (Editable in Editor)
@export var delay: float
@export_file("*.txt") var dialogue_file: String

# Actual text to be displayed
var RTL: RichTextLabel
var nextButton: TextureButton
var lines: Array

var index = 0

# Start function (Called once at start)
func _ready() -> void:
	# Extract all dialogue lines and split them into an array
	lines = extractTextFile().split(",")
	
	# Fine Dialogue Child
	RTL = self.get_child(2)
	
	# Setup the NEXT button
	nextButton = self.get_child(3)
	nextButton.pressed.connect(checkNextButtonPress)
	
	# Initial dialogue function
	typeDialogue(delay, lines, RTL)

# Update function (Called every frame) -> (Delta is essentially time passed since last frame)
func _process(delta: float) -> void:
	pass
	
# Activates when NEXT button is pressed
func checkNextButtonPress() -> void:
	if RTL.visible_characters < lines[index].length():
		RTL.visible_characters = lines[index].length()
	elif RTL.visible_characters >= lines[index].length():
		nextLine()
	
# Type dialogue function
func typeDialogue(delay: float, dialogue_list: Array, RTL: RichTextLabel) -> void:
	# Make text invisible first
	RTL.text = lines[index]
	RTL.visible_characters = 0
	
	# Get max character length of dialogue and make tracker variable
	var max_characters = dialogue_list[index].length()
	
	# Type dialogue with delay
	while RTL.visible_characters < max_characters:
		await get_tree().create_timer(delay).timeout
		RTL.visible_characters = RTL.visible_characters + 1

# Get the next line of dialogue
func nextLine():
	if index + 1 < len(lines):
		index = index + 1
		RTL.visible_characters = 0
		typeDialogue(delay, lines, RTL)
	
# Extract the dialogue from .txt file
func extractTextFile() -> String:
	if dialogue_file != "":
		var file = FileAccess.open(dialogue_file, FileAccess.READ)
		var content = file.get_as_text()
		
		return content
	else:
		return ""
