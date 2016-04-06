initialization
initializeWidgets
	(categoryLabel := self newLabel) label: 'Category'.
	(categoryInput := self newTextInput)
		autoAccept: true;
		text: 'Unclassified'.
	(prefixLabel := self newLabel) label: 'Prefix for class names'.
	(prefixInput := self newTextInput)
		autoAccept: true;
		text: ''.
	(clashPrefixLabel := self newLabel) label: 'Prefix for name conflicts'.
	(clashPrefixInput := self newTextInput)
		autoAccept: true;
		text: ''.
	(accessorsCheckbox := self newCheckBox)
		label: 'Add acessors';
		state: true.
	(methodsCheckbox := self newCheckBox)
		label: 'Override existing method definitions';
		state: true.
	(lazyInitialization := self newCheckBox)
		label: 'Use lazy initialization (default values in getters)';
		state: true.
	(generateButton := self newButton)
		label: 'Generate';
		action: [ self runGenerator ].

	self focusOrder
		add: categoryInput;
		add: generateButton