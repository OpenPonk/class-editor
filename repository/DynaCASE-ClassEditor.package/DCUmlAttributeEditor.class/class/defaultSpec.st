as yet unclassified
defaultSpec
	^ SpecColumnLayout composed
		newRow: [ :r | r add: #noDefaultRadio left: 0 ] height: self toolbarHeight;
		newRow: [ :r | 
			r
				add: #numberRadio width: 140;
				add: #numberInput ]
			height: self toolbarHeight;
		newRow: [ :r | 
			r
				add: #booleanRadio width: 140;
				add: #booleanSelect ]
			height: self toolbarHeight;
		newRow: [ :r | 
			r
				add: #stringRadio width: 140;
				add: #stringInput ]
			height: self toolbarHeight;
		newRow: [ :r | 
			r
				add: #collectionRadio width: 140;
				add: #collectionSelect ]
			height: self toolbarHeight;
		newRow: [ :r | 
			r
				add: #codeRadio width: 140;
				add: #codeInput ]
			height: self toolbarHeight;
		newRow: [ :r |  ];
		yourself