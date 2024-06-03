@tool
class_name NullCardCollection extends CardCollection

@export var cards: Array

func _get_all():
	return cards

func _validate_property(property):
	if property.name == "all":
		property.usage &= ~PROPERTY_USAGE_EDITOR
