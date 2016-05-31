adding
addConfigPane
	| pane defaultValues types |
	defaultValues := self lastValues.
	pane := WizardSinglePane new.
	pane name: 'Source Code Generator'.
	pane
		addPart:
			(TextFieldPart new
				inGroupboxNamed: 'Target package';
				defaultValue: (defaultValues at: #package))
		associatedTo: #package.
	pane
		addPart:
			(TextFieldPart new
				inGroupboxNamed: 'Prefix for class names';
				defaultValue: (defaultValues at: #classPrefix))
		associatedTo: #classPrefix.
	pane
		addPart:
			(TextFieldPart new
				inGroupboxNamed: 'Prefix for name conflicts';
				defaultValue: (defaultValues at: #conflictPrefix))
		associatedTo: #conflictPrefix.
	pane
		addPart:
			(CheckboxPart new
				label: 'Add accessors';
				defaultValue: (defaultValues at: #addAccessors))
		associatedTo: #addAccessors.
	pane
		addPart:
			(CheckboxPart new
				label: 'Override existing methods';
				defaultValue: (defaultValues at: #overrideMethods))
		associatedTo: #overrideMethods.
	types := {#lazy -> 'Lazy (default values in getters)'.
	#eager -> 'Eager (default values in #initialize)'}.
	pane
		addPart:
			(DropListPart new
				inGroupboxNamed: 'Initialization type';
				horizontalSize: 300;
				list: types;
				format: [ :pair | pair value ];
				transformed: [ :pair | pair key ];
				defaultValue: (types detect: [ :each | each key = (defaultValues at: #initializationType) ]))
		associatedTo: #initializationType.
	self addPane: pane