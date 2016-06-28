adding
addAccessorsPartTo: aPane
	| defaultValues types |
	defaultValues := self lastValues.
	aPane
		addPart:
			(CheckboxPart new
				label: 'Add accessors';
				defaultValue: (defaultValues at: #addAccessors))
		associatedTo: #addAccessors.
	types := {#simple -> 'Simple (no synchronization)'.
	#direct -> 'Direct synchronization (updating both sides)'.
	#fame -> 'Intermediate object (use Fame MultiValueLinks)'}.
	aPane
		addPart:
			(DropListPart new
				inGroupboxNamed: 'Accessors style';
				horizontalSize: 300;
				list: types;
				format: [ :pair | pair value ];
				transformed: [ :pair | pair key ];
				defaultValue: (types detect: [ :each | each key = (defaultValues at: #accessorsStyle) ]))
		associatedTo: #accessorsStyle