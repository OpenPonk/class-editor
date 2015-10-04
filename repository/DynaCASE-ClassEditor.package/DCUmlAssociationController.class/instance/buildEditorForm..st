ui hooks
buildEditorForm: form
	(form addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue.
			self refreshFigure ].
	(form addCheckbox: 'Source Navigable')
		state: self model sourceEnd isNavigable;
		whenChangedDo: [ :val | 
			self model sourceEnd isNavigable: val.
			self refreshFigure ].
	(form addCheckbox: 'Target Navigable')
		state: self model targetEnd isNavigable;
		whenChangedDo: [ :val | 
			self model targetEnd isNavigable: val.
			self refreshFigure ]