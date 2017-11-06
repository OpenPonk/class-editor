forms
applyStereotype: aStereotypeModel to: aModel
	(aModel appliedStereotypes
		anySatisfy: [ :each | each umlClassName = aStereotypeModel umlClassName ])
		ifTrue: [ ^ self ].
	self removeStereotypesIn: aModel.
	aModel applyStereotype: aStereotypeModel implementationClass new