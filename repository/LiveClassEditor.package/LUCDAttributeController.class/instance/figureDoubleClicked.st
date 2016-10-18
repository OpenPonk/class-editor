as yet unclassified
figureDoubleClicked
	| result |
	result := UIManager default request: 'Name' initialAnswer: self model name.
	result
		ifNotNil: [ self renameAttribute: self model name to: result inClass: self model parentType name.
			self model name: result ].
	self refreshFigure