generator - accessors
createAccessorsFor: anEnd in: aClass
	self createGetterFor: anEnd in: aClass.
	self createSetterFor: anEnd in: aClass.
	anEnd multiplicity upper > 1
		ifTrue: [ self createCollectionAccessorsFor: anEnd in: aClass ]