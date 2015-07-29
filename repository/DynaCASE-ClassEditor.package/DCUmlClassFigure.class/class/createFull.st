instance creation
createFull
	| cls c0 c1 c2 |
	cls := self new.
	c0 := DCUmlNameCompartmentFigure new.
	c0 add: c0 newNameFigure.
	c1 := DCUmlCompartmentFigure new.
	c2 := DCUmlCompartmentFigure new.
	cls
		add: c0;
		add: c1;
		add: c2.
	^ cls