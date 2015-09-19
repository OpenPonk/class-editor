examples
exampleStyledLabels
	| v c l1 l2 l3 |
	v := RTView new.

	c := DCUmlCompartmentFigure new.
	(l1 := DCUmlLabelFigure new) text: 'normal'.
	(l2 := DCUmlLabelFigure new) text: 'italic'.
	(l3 := DCUmlLabelFigure new) text: 'underlined'.

	c
		addAll:
			{l1.
			l2.
			l3}.

	c renderIn: v.
	v open