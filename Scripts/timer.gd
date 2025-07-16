extends Panel


var time: float = 120.0
var minutes: int = 0
var seconds: int = 0

func _process(delta: float) -> void:
	time -= delta
	minutes = int(fmod(time, 3600) / 60)
	seconds = int(fmod(time, 60))

	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d" % seconds

func stop() -> void:
	set_process(false)
	
func resume() -> void:
	set_process(true)
