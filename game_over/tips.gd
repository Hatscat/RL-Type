
extends Label

var tips = ["To live longer, try to not die", "Not so bad for a looser", "More pew-pew, less booooom", "Dying is fun !" ]


func _ready():
	randomize();
	var index = rand_range(0, tips.size())
	var string = tips[index]
	set_text(string);
	pass


