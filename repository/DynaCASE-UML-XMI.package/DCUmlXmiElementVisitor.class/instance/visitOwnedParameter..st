visitor
visitOwnedParameter: anElement
	elements
		at: anElement xmiId
		put: [ | param |
			(param := FAMIXParameter new) name: anElement @ #name.
			(self elementAt: anElement parent xmiId) addParameter: param.
			param ]