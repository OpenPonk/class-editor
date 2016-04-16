generator - accessors
createGetterFor: anAssociationEnd in: aClass
	aClass compile: (self getter: anAssociationEnd) classified: 'accessing'