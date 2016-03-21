accessing
associationEnds
	<MSEProperty: #associationEnds type: #DCFAMIXProperty opposite: #belongsTo>
	<multivalue>
	<MSEComment: 'Association ends of this association.'>
	^ Array with: self sourceEnd with: self targetEnd