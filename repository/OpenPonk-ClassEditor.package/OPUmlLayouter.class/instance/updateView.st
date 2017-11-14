userinterface
updateView
	| view |
	view := diagramController view.
	view signalUpdate.
	view canvas camera focusOnCenter