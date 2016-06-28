accessing
associationsGeneratorFor: aStyle
	aStyle = #simple
		ifTrue: [ ^ DCUmlCodeSimpleAssociationGenerator new ].
	aStyle = #direct
		ifTrue: [ ^ DCUmlCodeAssociationGenerator new ].
	aStyle = #fame
		ifTrue: [ ^ self notYetImplemented ].
	self error: 'Unrecognized style ' , aStyle