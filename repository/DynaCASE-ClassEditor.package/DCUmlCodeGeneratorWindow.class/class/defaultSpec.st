specs
defaultSpec
	^ SpecColumnLayout composed
		newRow: [ :r | 
			r
				add: #categoryLabel width: 70;
				add: #categoryInput ]
			height: 22;
		newRow: [ :r | r add: #accessorsCheckbox ] height: 22;
		newRow: [ :r |  ];
		newRow: [ :r | r add: #generateButton ] height: 50;
		yourself