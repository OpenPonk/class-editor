generator - accessors
createSetterFor: anAssociationEnd in: aClass
	aClass compile: (self setter: anAssociationEnd) classified: 'accessing'