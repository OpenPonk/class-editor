specs
defaultSpec
	^ SpecColumnLayout composed
		newRow: [ :r | 
			r
				add: #packageLabel width: 140;
				add: #packageDropList ]
			height: 22;
		newRow: [ :r |  ];
		newRow: [ :r | 
			r
				add: #importButton;
				add: #exportButton ]
			height: 50;
		yourself