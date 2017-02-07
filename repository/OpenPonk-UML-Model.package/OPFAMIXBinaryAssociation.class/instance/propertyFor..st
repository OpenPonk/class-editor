accessing
propertyFor: anAssociationEnd
	^ self sourceEnd = anAssociationEnd
		ifTrue: [ self source ]
		ifFalse: [ self target ]