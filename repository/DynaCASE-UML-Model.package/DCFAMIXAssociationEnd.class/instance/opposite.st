accessing
opposite
	<MSEProperty: #opposite type: #DCFAMIXAssociationEnd>
	<MSEComment: 'Retrieve the opposite association end.'>
	^ self association associationEnds detect: [ :each | each ~= self ]