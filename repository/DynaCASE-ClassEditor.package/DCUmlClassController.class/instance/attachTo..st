adding
attachTo: aDiagramController
	super attachTo: aDiagramController.
	self model attributes
		do: [ :attr | 
			| ac |
			ac := DCUmlAttributeController new.
			ac model: attr.
			self addAsTargetFor: ac ]