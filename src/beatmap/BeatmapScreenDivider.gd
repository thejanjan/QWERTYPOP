extends VSplitContainer

# The main ScreenDivider for beatmaps.
# Keeps the top and bottom halves of the screen in ratio with one another.

const screen_split = 0.74

func _process(delta):
	split_offset = get_viewport().get_visible_rect().size.y * screen_split
