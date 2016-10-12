ui hooks
buildEditorForm: aForm
	(aForm addTextInput: 'Name')
		autoAccept: false;
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self renameAttribute: self model name to: newValue inClass: self model parentType name.
			self model name: newValue.
			self refreshFigure ]