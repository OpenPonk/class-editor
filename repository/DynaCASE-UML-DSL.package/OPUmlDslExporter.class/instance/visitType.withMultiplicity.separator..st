visitor
visitType: aType withMultiplicity: aMultiplicity separator: aSeparator
	"
	foo : Object[1..1] => foo
	foo : String[1..1] => foo : String
	"

	aType name = 'Object' & (aMultiplicity lower = 1) & (aMultiplicity upper = 1)
		ifTrue: [  ].
	aType name ~= 'Object' & (aMultiplicity lower = 1) & (aMultiplicity upper = 1)
		ifTrue: [ stream
				nextPutAll: aSeparator;
				nextPutAll: aType name ].
	aMultiplicity lower ~= 1 | (aMultiplicity upper ~= 1)
		ifTrue: [ stream
				nextPutAll: aSeparator;
				nextPutAll: aType name;
				nextPutAll: aMultiplicity printRange ]