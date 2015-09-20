figures
updateFigure: aFigure from: aModel
	aFigure famixUpdate.
	aFigure figures size > 1
		ifTrue:
			[ 
			(aFigure figures allButFirst flatCollect: #figures)
				do:
					[ :label | 
					label element
						when: TRMouseLeftClick
						do:
							[ :evt | 
							label model isAttribute
								ifTrue: [ self attributeSelected: label model figure: label ].
							label model isMethod
								ifTrue: [ self methodSelected: label model figure: label ] ] ] ]