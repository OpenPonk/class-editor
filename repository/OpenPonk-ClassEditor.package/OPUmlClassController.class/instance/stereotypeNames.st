accessing
stereotypeNames
	(self diagramController model oclIsKindOf: #Profile)
		ifTrue: [ ^ #(Metaclass) ].
	^ self model appliedStereotypes collect: #umlClassName