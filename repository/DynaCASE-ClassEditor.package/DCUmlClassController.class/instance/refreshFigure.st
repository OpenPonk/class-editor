figures
refreshFigure
	| nameLabel |
	nameLabel := self diagramElement ownedElements
		detect: [ :each | each isKindOf: DCUmlNameLabel ].
	nameLabel text: self model name.
	self logCr: nameLabel text.
	nameLabel changed.
	self diagramElement changed.
	super refreshFigure