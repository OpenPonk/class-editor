figures
renderFigureIn: aView
	| sourceElement |
	diagramElement := self createDiagramElement.
	sourceElement := ((diagramController controllers
		select: [ :each | each isKindOf: OPUmlPackageController ])
		detect: [ :each | each model packageImports includes: self model ]) diagramElement.
	"	diagramElement source: (diagramController diagramElementForModel: self model specific)."
	diagramElement source: sourceElement.
	diagramElement target: (diagramController diagramElementForModel: self model importedPackage).
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure