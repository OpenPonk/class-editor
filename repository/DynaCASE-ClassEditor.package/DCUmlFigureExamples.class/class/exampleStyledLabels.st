examples
exampleStyledLabels
	| v c l1 l2 l3 |
	v := RTView new.

	c := DCUmlCompartmentFigure new.
	(l1 := DCUmlLabelFigure new) text: 'normal'.
	(l2 := DCUmlLabelFigure new)
		emphasis: TextEmphasis italic;
		text: 'italic'.
	(l3 := DCUmlLabelFigure new)
		emphasis: TextEmphasis underlined;
		text: 'underlined'.

	c
		add: l1;
		add: l2;
		add: l3.

	c renderIn: v.
	v open