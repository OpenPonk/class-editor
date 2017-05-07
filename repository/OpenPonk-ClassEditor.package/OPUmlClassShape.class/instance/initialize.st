initialization
initialize
	super initialize.
	self sharedStyle fillColor: Color white.
	nameLabel := OPUmlNameLabel new.
	nameLabel text: [ :model | model name ].
	nameLabel localStyle: (OPUmlStyle new fontSize: 11).
	nameLabel owningElement: self.
	attributes := OPUmlCompartment new.
	attributes owningElement: self.
	operations := OPUmlCompartment new.
	operations owningElement: self