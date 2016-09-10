transforming
attributeFor: anAttribute
	^ (self entityFor: anAttribute)
		isStatic: anAttribute isStatic;
		multiplicity: anAttribute multiplicity;
		yourself