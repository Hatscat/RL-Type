
extends Label

var tips = ["To live longer, try to not die", "Not so bad for a loser", "More pew-pew, less booooom", "Dying is fun !" ]


func _ready():
	randomize()
	var index = randi() % tips.size()
	var string = tips[index]
	set_text(string);
	pass


