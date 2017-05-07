figures
showModelInDiagram: aModel
	| controller |
	controller := self newControllerFor: aModel.
	self controllers add: controller.
	controller diagramController: self.
	controller renderFigureIn: self view