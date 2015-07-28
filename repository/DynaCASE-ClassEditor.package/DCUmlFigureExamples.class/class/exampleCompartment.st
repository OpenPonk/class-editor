examples
exampleCompartment
	| v c l1 l2 |
	v := RTView new.

	c := DCUmlCompartmentFigure new.
	(l1 := DCUmlLabelFigure new) text: 'first'.
	(l2 := DCUmlLabelFigure new) text: 'second'.

	c add: l1.
	c add: l2.

	c remove: l1.

	c element @ RTDraggable.

	"
l2 text: 'y'.

c update.
"

	c renderIn: v.


	v open