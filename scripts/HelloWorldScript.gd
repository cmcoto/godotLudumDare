
extends RichTextLabel

# member variables here, example:
var count = 0
# var b="textvar"

func _ready():
	# Initialization here
	self.add_text("Hello World")




func _on_Timer_2_timeout():
	count += 1
	self.clear()
	self.add_text(str("Hello World! Elapsed Time: ", count))
