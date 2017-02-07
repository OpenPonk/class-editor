accessing
icons
	<MSEProperty: #icons type: #OPFAMIXImage opposite: #stereotype>
	<multivalued>
	<MSEComment: 'Icons representing this stereotype.'>
	<package: #DC>
	^ icons ifNil: [ icons := FMMultivalueLink on: self opposite: #stereotype: ]