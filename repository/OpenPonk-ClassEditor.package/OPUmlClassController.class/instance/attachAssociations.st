adding
attachAssociations
	| models associations |
	models := self diagramController controllers
		select:
			[ :each | each class = OPUmlClassController | (each class = OPUmlAssociationController) ]
		thenCollect: #model.

	associations := ((self model associations reject: [ :each | models includes: each ])
		select: [ :each | models includes: each from ])
		select: [ :each | models includes: each to ].

	associations
		do:
			[ :link | 
			| lc |
			lc := OPUmlAssociationController new.
			lc model: link.
			lc source: (self diagramController controllerForModel: link from).
			(self diagramController controllerForModel: link to) addAsTargetFor: lc ]