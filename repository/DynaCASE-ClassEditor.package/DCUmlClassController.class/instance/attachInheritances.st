adding
attachInheritances
	| models inheritances |
	models := self diagramController controllers
		select: [ :each | 
			(each isKindOf: DCUmlClassController)
				| (each isKindOf: DCUmlInheritanceController) ]
		thenCollect: #model.
	inheritances := (self model subInheritances , self model superInheritances
		reject: [ :each | models includes: each ])
		select: [ :each | (models includes: each from) & (models includes: each to) ].
	inheritances
		do: [ :link | 
			| lc |
			lc := (self diagramController controllerNameFor: link) new.
			lc model: link.
			lc source: (self diagramController controllerForModel: link from).
			(self diagramController controllerForModel: link to) addAsTargetFor: lc ]