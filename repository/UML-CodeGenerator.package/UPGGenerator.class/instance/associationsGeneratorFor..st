accessing
associationsGeneratorFor: aStyle
	aStyle = #simple
		ifTrue: [ ^ UPGSimpleAccessorsGenerator new ].
	aStyle = #direct
		ifTrue: [ ^ UPGDirectAssociationGenerator new ].
	aStyle = #fame
		ifTrue: [ ^ self notYetImplemented ].
	self error: 'Unrecognized style ' , aStyle