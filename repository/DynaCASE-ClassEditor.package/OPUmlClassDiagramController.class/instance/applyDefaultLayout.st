userinterface
applyDefaultLayout
	self controllers ifNotEmpty: [ self applyAutoLayout ].
	self updateView.
	self view canvas camera focusOnCenter