examples
exampleNameCompartment
	| v c stereo n |
	v := RTView new.

	c := DCUmlNameCompartmentFigure new.
	stereo := c newStereotypeFigure.
	n := c newNameFigure.

	stereo text: '<<class>>'.
	n text: 'Cladddss'.

	c add: stereo.
	c add: n.

	c element @ RTDraggable.

	"
l2 text: 'y'.

c update.
"

	c renderIn: v.


	v open