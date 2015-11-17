ui hooks
buildEditorForm: form
	(form addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue.
			self refreshFigure ].
	(form addCheckbox: self model source name, ' end navigable')
		state: self model sourceEnd isNavigable;
		whenChangedDo: [ :val | 
			self model sourceEnd isNavigable: val.
			self refreshFigure ].
	(form addTextInput: self model source name, ' end name')
		text: self model sourceEnd name;
		whenTextIsAccepted: [ :newValue | 
			self model sourceEnd name: newValue.
			self refreshFigure ].
	(form addTextInput: 'Multiplicity min')
		text: self model sourceEnd multiplicity printLower;
		whenTextIsAccepted:
				[ :val | 
			val
				ifNotEmpty: [ self model sourceEnd multiplicity lower: val asString.
					self refreshFigure ] ].
	(form addTextInput: 'Multiplicity max')
		text: self model sourceEnd multiplicity printUpper;
		whenTextIsAccepted:
				[ :val | 
			val
				ifNotEmpty:
					[ | num |
					num := val = '*'
						ifTrue: [ DCUnlimitedNatural max ]
						ifFalse: [ (NumberParser on: val)
								failBlock: [  ];
								nextNumber ].
					num ifNotNil: [ self model sourceEnd multiplicity upper: num ].
					self refreshFigure ] ].
	(form addCheckbox: self model target name, ' navigable')
		state: self model targetEnd isNavigable;
		whenChangedDo: [ :val | 
			self model targetEnd isNavigable: val.
			self refreshFigure ].
	(form addTextInput: self model target name, ' end name')
		text: self model targetEnd name;
		whenTextIsAccepted: [ :newValue | 
			self model targetEnd name: newValue.
			self refreshFigure ].
	(form addTextInput: 'Multiplicity min')
		text: self model targetEnd multiplicity printLower;
		whenTextIsAccepted:
				[ :val | 
			val
				ifNotEmpty: [ self model targetEnd multiplicity lower: val asString.
					self refreshFigure ] ].
	(form addTextInput: 'Multiplicity max')
		text: self model targetEnd multiplicity printUpper;
		whenTextIsAccepted:
				[ :val | 
			val
				ifNotEmpty:
					[ | num |
					num := val = '*'
						ifTrue: [ DCUnlimitedNatural max ]
						ifFalse: [ (NumberParser on: val)
								failBlock: [  ];
								nextNumber ].
					num ifNotNil: [ self model targetEnd multiplicity upper: num ].
					self refreshFigure ] ]