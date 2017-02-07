adding
attachProperties
	self model attributes
		do: [ :attr | 
			| ac |
			ac := (self diagramController controllerNameFor: attr) new.
			ac model: attr.
			self addAsTargetFor: ac ].
	self model methods
		do: [ :method | 
			| mc |
			mc := (self diagramController controllerNameFor: method) new.
			mc model: method.
			self addAsTargetFor: mc ]