generator - association
associationPragmaFor: anAssociationEnd
	^ Pragma
		keyword: #DCType:role:name:multiplicity:
		arguments:
			{anAssociationEnd property name.
			anAssociationEnd name.
			anAssociationEnd association name.
			(self multiplicityFor: anAssociationEnd multiplicity)}