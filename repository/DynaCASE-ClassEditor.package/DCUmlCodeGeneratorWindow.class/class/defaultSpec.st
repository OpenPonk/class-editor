specs
defaultSpec
	^ SpecColumnLayout composed
		newRow: [ :r | 
			r
				add: #categoryLabel width: 140;
				add: #categoryInput ]
			height: 22;
		newRow: [ :r | 
			r
				add: #prefixLabel width: 140;
				add: #prefixInput ]
			height: 22;
		newRow: [ :r | 
			r
				add: #clashPrefixLabel width: 140;
				add: #clashPrefixInput ]
			height: 22;
		newRow: [ :r | r add: #accessorsCheckbox ] height: 22;
		newRow: [ :r | r add: #methodsCheckbox ] height: 22;
		newRow: [ :r | r add: #lazyInitialization ] height: 22;
		newRow: [ :r |  ];
		newRow: [ :r | r add: #generateButton ] height: 50;
		yourself