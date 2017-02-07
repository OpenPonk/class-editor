accessing
opposite
	<MSEProperty: #opposite type: #OPFAMIXProperty>
	<MSEComment: 'Retrieve the opposite association end.'>
	^ self association associationEnds detect: [ :each | each ~= self ]