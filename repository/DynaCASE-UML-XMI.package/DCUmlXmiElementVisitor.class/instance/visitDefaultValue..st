visitor
visitDefaultValue: anElement
	elements
		at: anElement xmiId
		put: [ (self elementAt: anElement parent xmiId)
				defaultValue: (DCFAMIXValueSpecification from: anElement @ #value).
			nil ]