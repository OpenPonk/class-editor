adding
attachTo: aDiagramController
	super attachTo: aDiagramController.
	self model attributes
		do:
			[ :attr | 
			| ac |
			ac := DCUmlAttributeController new.
			ac model: attr.
			self addAsTargetFor: ac ].
	self model methods
		do:
			[ :method | 
			| mc |
			mc := DCUmlMethodController new.
			mc model: method.
			self addAsTargetFor: mc ]