palette
rebuildPalette
	self editor paletteModel createPaletteFor: self.
	self editor paletteModel rebuildWidget.
	self selectView