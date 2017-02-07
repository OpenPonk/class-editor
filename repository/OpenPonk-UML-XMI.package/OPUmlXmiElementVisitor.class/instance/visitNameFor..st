visitor
visitNameFor: aName
	(aName beginsWith: 'thecustomprofile:')
		ifTrue: [ ^ #visitEACustomProfile: ].
	^ ('visit' , (aName copyReplaceAll: ':' with: '') capitalized , ':') asSymbol