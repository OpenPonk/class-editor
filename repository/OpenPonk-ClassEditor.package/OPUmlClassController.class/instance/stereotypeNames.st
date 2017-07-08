accessing
stereotypeNames
	(self diagramController model packagedElements
		anySatisfy: [ :stereo | 
			(stereo isKindOf: OPUMLStereotype)
				and: [ stereo ownedAttributes
						anySatisfy: [ :attr | attr type = self model and: [ attr association isKindOf: OPUMLExtension ] ] ] ])
		ifTrue: [ ^ #(Metaclass) ].
	^ #()