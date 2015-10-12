accessing
associationEnds
	<MSEProperty: #associationEnds type: #DCFAMIXAssociationEnd opposite: #association>
	<multivalue>
	<MSEComment: 'Association ends of this association.'>
	^ Array with: self sourceEnd with: self targetEnd