as yet unclassified
primitiveTypeForName: aName
	(aName beginsWith: 'EAJava_')
		ifTrue: [ ^ (aName splitOn: '_') last ].
	"maybe create a new class instead?"
	self error: 'Unrecognized type ' , aName