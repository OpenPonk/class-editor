as yet unclassified
accessorFor: anAttribute of: aStereotype
	^ MAPluggableAccessor
		read: [ :me | aStereotype perform: anAttribute name asSymbol ]
		write: [ :me :newValue | 
			aStereotype perform: (anAttribute name , ':') asSymbol with: newValue.
			controller refreshFigure ]