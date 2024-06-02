class_name JSONFileCardCollection extends CardCollection

@export var json_file_path: String

var _cards: Array[String] = []

func _load():
	if not _cards and json_file_path:
		var read = JSONFileCardDB._load_json(json_file_path)
		_cards.assign(read)

func _init(path = null):
	if path:
		json_file_path = path

func _get_all():
	# Have to call it here, since _init() is called before exported
	# vars have been set
	_load()
	return _cards
