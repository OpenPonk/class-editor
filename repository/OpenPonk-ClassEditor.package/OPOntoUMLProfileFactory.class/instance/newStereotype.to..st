instance creation
newStereotype: aName to: aBaseClass
	| stereotype extension baseProperty extensionProperty |
	stereotype := OPUMLStereotype new name: aName.
	extension := OPUMLExtension new.
	(baseProperty := OPUMLProperty new)
		name: 'base_' , aBaseClass name;
		owningClass: stereotype;
		type: aBaseClass.
	(extensionProperty := OPUMLProperty new)
		name: 'extension_' , stereotype name;
		owningAssociation: extension;
		type: stereotype.
	extension
		memberEnds:
			{baseProperty.
			extensionProperty}.
	extension ownedEnd: extensionProperty.
	extensionProperty lowerValue: (OPUMLLiteralInteger new value: 0).
	^ {stereotype.
	extension}