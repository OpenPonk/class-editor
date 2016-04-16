as yet unclassified
stringSpecificationFor: aValue
	(aValue isMemberOf: RBMessageNode)
		ifTrue: [ ^ aValue receiver name , ' ' , aValue selector ].
	^ aValue asString