visitor
visitUmlStereotype: anElement
	"this is a non-standard extension"

	elements
		at: anElement xmiId
		put: [ | stereotype |
			(stereotype := OPFAMIXStereotype new)
				name: anElement @ #name;
				instVarNamed: #mooseID put: (self idFrom: anElement xmiId).
			(self elementAt: anElement parent xmiId) addStereotype: stereotype.
			stereotype ]