class_name NullCardDB extends CardDB

## This implementation expects cards to be provided externally
## and simply returns them as-is when requested

func get_card(card_id):
	return card_id
