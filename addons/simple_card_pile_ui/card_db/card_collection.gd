class_name CardCollection extends Resource

@export var all: Array:
	get = _get_all

func _get_all():
	assert(false, "not implemented")

func _validate_property(prop):
	if prop.name == "all":
		prop.usage |= PROPERTY_USAGE_READ_ONLY
