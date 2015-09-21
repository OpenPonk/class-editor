figures
createFigureInView: aView
	| class |
	class := DCUmlClassFigure new.
	class famixClass: self model.
	class renderIn: aView.
"	class element @ DCRTFocusable."
	^ class element