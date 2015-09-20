figures
createFigureInView: aView
	| class |
	class := DCRTClass new.
	self updateFigure: class from: self model.
	class renderIn: aView.
	class element @ DCRTFocusable.
	^ class element