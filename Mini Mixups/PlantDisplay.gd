extends Sprite

export (Resource) var resource
var daysSincePlanted = 0


func _ready():
	daysSincePlanted = 0;
	TimeManager.connect("onNewDay", self, "_On_New_Day")
	self.texture = resource.stages[0]
	

func _On_New_Day():
	daysSincePlanted += 1
	if daysSincePlanted < resource.daysToGrow:
		self.texture = resource.stages[daysSincePlanted]
	if daysSincePlanted >= resource.daysToGrow + 2:
		pass
