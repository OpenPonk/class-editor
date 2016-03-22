as yet unclassified
visitUmlPackage: anElement
	elements
		at: anElement xmiId
		put: [ | model |
			(model := MooseModel new)
				name: anElement @ #name;
				instVarNamed: #mooseID put: anElement xmiId.
			(anElement parent name = 'packagedElement'
				and: [ anElement parent @ #xmi:type = 'uml:Package' ])
				ifTrue: [ elements at: (self elementAt: anElement parent xmiId) put: model ].
			model ]