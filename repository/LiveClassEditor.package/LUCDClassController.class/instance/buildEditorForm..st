ui hooks
buildEditorForm: aForm
	(aForm addTextInput: 'Name')
		autoAccept: false;
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self renameClass: self model name to: newValue.
			self model name: newValue.
			self refreshFigure ]