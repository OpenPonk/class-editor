ui hooks
buildEditorForm: aForm
	| converter |
	converter := DCUmlModelToStringConverter new.
	"(aForm addTextInput: 'Stereotype')
		text: self model stereotype;
		whenTextIsAccepted: [ :newValue | self model stereotype: newValue ]."

	(aForm addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | self model name: newValue ].

	(aForm addText: 'Attributes')
		text: (converter attributesFor: self model);
		whenTextIsAccepted: [ :newValue |  ]	"self model attributes: newValue asString lines"

	"(aForm addText: 'Methods')
		text: self model operations asStringWithCr;
		whenTextIsAccepted: [ :newValue | self model operations: newValue asString lines ]"