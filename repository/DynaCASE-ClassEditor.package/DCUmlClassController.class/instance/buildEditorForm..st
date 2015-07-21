ui hooks
buildEditorForm: aForm
	(aForm addTextInput: 'Stereotype')
		text: self model stereotype;
		whenTextIsAccepted: [ :newValue | self model stereotype: newValue ].
		
	(aForm addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | self model name: newValue ].
		
	(aForm addText: 'Attributes')
		text: self model attributes asStringWithCr;
		whenTextIsAccepted: [ :newValue | self model attributes: newValue asString lines ].
		
	(aForm addText: 'Methods')
		text: self model methods asStringWithCr;
		whenTextIsAccepted: [ :newValue | self model methods: newValue asString lines ]