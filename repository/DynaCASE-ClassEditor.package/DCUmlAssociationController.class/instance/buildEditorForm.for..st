ui hooks
buildEditorForm: form for: anEnd
	form addLabel: 'End: ' , anEnd declaredType name.
	(form addCheckbox: 'Is navigable?')
		state: anEnd isNavigable;
		whenChangedDo: [ :val | 
			anEnd isNavigable: val.
			self refreshFigure ].
	(form addTextInput: 'Role name')
		text: anEnd name;
		whenTextIsAccepted: [ :newValue | 
			anEnd name: newValue.
			self refreshFigure ].
	(form addDroplist: 'Aggregation')
		items:
			(Array
				with: DCUmlAggregationKind none
				with: DCUmlAggregationKind shared
				with: DCUmlAggregationKind composite);
		displayBlock: [ :each | each asString ];
		setSelectedItem: anEnd aggregation;
		whenSelectedItemChanged: [ :newValue | 
			anEnd aggregation: newValue.
			self refreshFigure ].

	(form addTextInput: 'Multiplicity min')
		text: anEnd multiplicity printLower;
		whenTextIsAccepted:
				[ :val | 
			val
				ifNotEmpty: [ anEnd multiplicity lower: val asNumber.
					self refreshFigure ] ].
	(form addTextInput: 'Multiplicity max')
		text: anEnd multiplicity printUpper;
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
					num ifNotNil: [ anEnd multiplicity upper: num ].
					self refreshFigure ] ]