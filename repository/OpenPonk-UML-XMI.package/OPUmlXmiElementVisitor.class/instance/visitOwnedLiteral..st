visitor
visitOwnedLiteral: anElement
	elements
		at: anElement xmiId
		put: [ | attr |
			(attr := OPFAMIXProperty new) name: anElement @ #name.
			(self elementAt: anElement parent xmiId) addAttribute: attr.
			attr ]