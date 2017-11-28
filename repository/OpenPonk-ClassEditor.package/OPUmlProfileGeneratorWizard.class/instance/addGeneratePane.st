adding
addGeneratePane
	| pane prefixPart packagePart |
	pane := WizardSinglePane new.
	pane name: 'Generate code for profile ' , profile name.
	(prefixPart := TextFieldPart new)
		inGroupboxNamed: 'Class Prefix';
		defaultValue: profile name.
	(packagePart := TextFieldPart new)
		inGroupboxNamed: 'Target Package';
		defaultValue: profile name , 'Profile'.
	pane row: prefixPart associatedTo: #prefix.
	pane row: packagePart associatedTo: #package.
	pane
		condition: [ :dict | (dict at: #prefix) isNotEmpty & (dict at: #package) isNotEmpty ]
		named: 'Prefix and package must not be empty.'.
	self addPane: pane