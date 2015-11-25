generator - accessors
associationGetterPragmaFor: anAssociationEnd
	^ Pragma
		keyword: #DCType:name:multiplicity:
		arguments:
			{(self typeNameFor: anAssociationEnd).
			anAssociationEnd association name.
			(self multiplicityFor: anAssociationEnd multiplicity)}