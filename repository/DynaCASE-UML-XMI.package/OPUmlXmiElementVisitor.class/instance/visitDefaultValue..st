visitor
visitDefaultValue: anElement
	elements
		at: anElement xmiId
		put: [ (self elementAt: anElement parent xmiId)
				defaultValue: (OPFAMIXValueSpecification from: anElement @ #value).
			nil ]