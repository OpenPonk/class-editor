descriptions
descriptionUpper
	<magritteDescription>
	^ MANumberDescription new
		accessor: #upper;
		label: 'Max';
		priority: 2;
		comment: '* for unlimited';
		beRequired;
		yourself