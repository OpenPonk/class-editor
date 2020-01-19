removing
removeModel
	| ownerModel connectedAssociations connectedGeneralizations |
	ownerModel := diagramController model.
	connectedAssociations := ownerModel packagedElements
		select: [ :each | 
			(each isKindOf: OPUMLAssociation)
				and: [ each memberEnds anySatisfy: [ :any | any type = model ] ] ].
	connectedGeneralizations := ((ownerModel packagedElements
		select: [ :each | each isKindOf: OPUMLGeneralizationSet ])
		flatCollect: [ :each | each generalizations ])
		select: [ :each | each general = model or: [ each specific = model ] ].
	connectedAssociations , connectedGeneralizations
		do: [ :each | (diagramController controllerForModel: each) removeModel ].
	self remove.
	ownerModel packagedElements remove: self model