class_name JSONFileCardDB extends CardDB

@export_file("*.json") var json_file_path: String

var cards: Array[CardUIData]

func _init(path = null):
	if path:
		json_file_path = path

static func _load_json(path):
	if path:
		var json = FileAccess.get_file_as_string(path)
		var parsed = JSON.parse_string(json)
		return parsed
	return []

## This method should be overridden to add custom processing in subclasses
func _prepare_single_card(json):
	var card = ResourceLoader.load(json.resource_script_path).new()
	card.frontface_texture = load(json.texture_path)
	card.backface_texture = load(json.backface_texture_path)

	for key in json.keys():
		if key not in ["texture_path", "backface_texture_path", "resource_script_path"]:
			card[key] = json[key]

	return card

func prepare():
	var json = _load_json(json_file_path)
	cards.clear()
	for raw_card in json:
		cards.append(_prepare_single_card(raw_card))


func get_card(card_id):
	for card in cards:
		if card.nice_name == card_id:
			return card
