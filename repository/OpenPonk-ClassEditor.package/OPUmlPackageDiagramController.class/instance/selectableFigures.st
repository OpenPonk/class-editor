figures
selectableFigures
	^ (self controllers select: [ :each | each isKindOf: OPUmlClassController ])
		collect: #figure