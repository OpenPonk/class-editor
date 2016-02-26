userinterface
rebuild
	self disableRefresh.
	super rebuild.
	self enableRefresh.
	self controllers select: [ :each | each isMemberOf: DCUmlClassController ] thenDo: [ :each | each refreshFigure ].
	self controllers ifNotEmpty: [ self applyAutoLayout ].
	self updateView.
	self view canvas camera focusOnCenter