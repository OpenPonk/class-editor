initialization
initializeWidgets
	(categoryLabel := self newLabel) label: 'Category'.
	(categoryInput := self newTextInput)
		autoAccept: true;
		text: 'Unclassified'.
	(accessorsCheckbox := self newCheckBox)
		label: 'Add acessors';
		state: true.
	(generateButton := self newButton)
		label: 'Generate';
		action: [ self runGenerator ].

	self focusOrder
		add: categoryInput;
		add: generateButton