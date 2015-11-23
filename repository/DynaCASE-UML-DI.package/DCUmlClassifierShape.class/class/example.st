as yet unclassified
example
	| el lbl comp compLbl v |
	el := DCUmlClassifierShape new.
	lbl := DCUmlNameLabel new.
	lbl text: 'Name'.
	lbl localStyle: (DCUmlStyle new fontSize: 11).
	lbl owningElement: el.
	comp := DCUmlCompartment new.
	comp owningElement: el.
	(compLbl := DCUmlLabel new)
		owningElement: comp;
		text: 'attr'.
	v := RTView new.
	el renderIn: v.
	el rtElement when: TRMouseLeftClick do: [ :evt |  ].
	el rtElement @ RTResizable @ RTDraggable.
	v