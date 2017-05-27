construction
createModelIn: aTargetController andShowInDiagram: aDiagramController
	| sourceProp targetProp |
	model := OPUMLAssociation new.
	(sourceProp := OPUMLProperty new)
		owningAssociation: model;
		type: sourceController model.
	(targetProp := OPUMLProperty new)
		owningAssociation: model;
		type: aTargetController model.
	model memberEnds
		add: sourceProp;
		add: targetProp.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController