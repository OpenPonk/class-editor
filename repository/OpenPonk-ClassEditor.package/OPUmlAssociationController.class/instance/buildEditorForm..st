ui hooks
buildEditorForm: form
	(form addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue.
			self refreshFigure ].
	self buildEditorForm: form for: self model sourceEnd.
	self buildEditorForm: form for: self model targetEnd