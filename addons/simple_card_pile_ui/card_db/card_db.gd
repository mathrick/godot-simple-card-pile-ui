class_name CardDB extends Resource

## This method will be called at least once by [CardPileUI] before the
## first call to [method get_card]. Any setup, loading, etc. should happen here
func prepare():
	pass

## This method needs to be overridden to implement card retrieval.
## [param card_id] is an arbitrary value provided by the user used to identify
## the requested card. Each subclass decides what kind of ID it wants to use
func get_card(card_id: Variant) -> Variant:
	assert(false, "not implemented")
	return null
