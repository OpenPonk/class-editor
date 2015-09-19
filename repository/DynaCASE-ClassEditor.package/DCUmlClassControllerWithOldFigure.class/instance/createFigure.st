figures
createFigure
	| class |
	^ DCRTCallbackBuilder
		block:
			[ :view | 
			class := DCRTClass new.
			self updateFigure: class from: self model.
			class renderIn: view.
			class element @ DCRTFocusable.
			class element ]