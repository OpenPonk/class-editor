visitor
visitOwnedLiteral: anElement
	elements
		at: anElement xmiId
		put: [ | attr |
			(attr := DCFAMIXProperty new) name: anElement @ #name.
			(self elementAt: anElement parent xmiId) addAttribute: attr.
			attr ]