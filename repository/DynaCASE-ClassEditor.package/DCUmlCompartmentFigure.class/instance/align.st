updating
align
	| newWidth delta |
	newWidth := self parent minWidth.
	delta := (self width - newWidth) / 2.
	self width: newWidth.
	self figures translateBy: delta @ 0