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
	(form addEditableDroplist: 'Multiplicity')
		items: #('0..1' '1..1' '0..*' '1..*');
		setSelectedItem: anEnd multiplicity printFullRange;
		whenSelectedItemChanged: [ :val | 
			anEnd multiplicity: (DCFAMIXMultiplicity fromString: val).
			self refreshFigure ]