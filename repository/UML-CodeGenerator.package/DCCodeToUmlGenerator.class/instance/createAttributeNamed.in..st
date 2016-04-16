generator - attribute
createAttributeNamed: aSymbol in: aClass
	^ FAMIXAttribute new
		name: aSymbol;
		declaredType: (self attributeTypeFor: aSymbol in: aClass);
		multiplicity: (self multiplicityFor: aSymbol in: aClass);
		yourself