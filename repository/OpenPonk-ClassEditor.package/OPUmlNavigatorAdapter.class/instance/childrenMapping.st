accessing
childrenMapping
	^ {OPUMLPackage -> #packagedElements.
	OPUMLProfile -> #packagedElements.
	OPUMLModel -> #packagedElements.
	OPUMLClass -> [ :cls | cls ownedAttributes , cls ownedOperations ].
	OPUMLEnumeration -> #ownedLiterals}