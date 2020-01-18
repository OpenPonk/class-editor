figures
showAllElements
	self disableRefresh.
	(self allShowableElementsInModel: model)
		do: [ :each | self showModelInDiagram: each ].
	self enableRefresh.
	self controllers
		select: [ :each | each isKindOf: OPUmlClassController ]
		thenDo: #refreshFigure