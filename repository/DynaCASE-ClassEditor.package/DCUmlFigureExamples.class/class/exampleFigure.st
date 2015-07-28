examples
exampleFigure
	| v l |
	v := RTView new.

	l := DCUmlLabelFigure new.

	l renderIn: v.

	l text: 'label'.

	"
l remove.
"

	"
l renderIn: v.
"

	v open