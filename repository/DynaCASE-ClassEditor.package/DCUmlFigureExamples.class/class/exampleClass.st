examples
exampleClass
	| v n c0 s c1 l11 l12 c2 l21 l22 cls |
	v := RTView new.

	c0 := DCUmlNameCompartmentFigure new.
	(s := c0 newStereotypeFigure) text: '<<class>>'.
	(n := c0 newNameFigure) text: 'Class'.
	c0
		add: s;
		add: n.

	c1 := DCUmlCompartmentFigure new.
	(l11 := DCUmlLabelFigure new) text: 'first'.
	(l12 := DCUmlLabelFigure new) text: 'second'.
	c1 add: l11.
	c1 add: l12.

	c2 := DCUmlCompartmentFigure new.
	(l21 := DCUmlLabelFigure new) text: 'first'.
	(l22 := DCUmlLabelFigure new) text: 'second'.
	c2 add: l21.
	c2 add: l22.

	cls := DCUmlClassFigure new.
	cls add: c0.
	cls add: c1.
	cls add: c2.

	"
cls remove: c2.

cls add: c2.

c1 remove: l11.
c1 remove: l12.

c2 remove: l22.
c2 add: l22.
"

	cls renderIn: v.


	l22 text: 'h'.

	"
c removeAll.
"



	v open