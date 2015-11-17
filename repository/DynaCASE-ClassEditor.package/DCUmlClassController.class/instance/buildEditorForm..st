ui hooks
buildEditorForm: aForm
	(aForm addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue capitalized.
			self refreshFigure ].
	(aForm addCheckbox: 'Is Abstract')
		state: self model isAbstract;
		whenChangedDo: [ :val | 
			self model isAbstract: val.
			self refreshFigure ]