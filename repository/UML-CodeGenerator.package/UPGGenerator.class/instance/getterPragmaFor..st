generator - accessors
getterPragmaFor: anAttribute
	^ Pragma
		keyword: #DCType:multiplicity:
		arguments:
			{(self typeNameFor: anAttribute).
			(self multiplicityFor: anAttribute multiplicity)}