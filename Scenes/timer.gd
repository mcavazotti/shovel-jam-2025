extends CanvasLayer

var elapsed_time = 0

func _ready():
	$"1 Second Timer".start()

func _process(delta):
	elapsed_time += delta
	$"Timer Label".text = str(elapsed_time)
