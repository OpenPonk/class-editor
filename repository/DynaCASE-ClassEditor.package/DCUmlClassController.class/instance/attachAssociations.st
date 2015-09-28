adding
attachAssociations
	| models inheritances |
	models := self diagramController controllers
		select:
			[ :each | each class = DCUmlClassController | (each class = DCUmlInheritanceController) ]
		thenCollect: #model.

	inheritances := ((self model subInheritances , self model superInheritances
		reject: [ :each | models includes: each ])
		select: [ :each | models includes: each superclass ])
		select: [ :each | models includes: each subclass ].

	inheritances
		do:
			[ :link | 
			| lc |
			lc := DCUmlInheritanceController new.
			lc model: link.
			lc source: (self diagramController controllerForModel: link subclass).
			(self diagramController controllerForModel: link superclass) addAsTargetFor: lc ]