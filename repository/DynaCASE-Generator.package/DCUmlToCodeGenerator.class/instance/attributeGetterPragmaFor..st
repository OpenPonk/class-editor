generator - accessors
attributeGetterPragmaFor: aFamixAttribute
	^ Pragma
		keyword: #DCType:multiplicity:
		arguments:
			{(self typeNameFor: aFamixAttribute).
			(self multiplicityFor: aFamixAttribute multiplicity)}