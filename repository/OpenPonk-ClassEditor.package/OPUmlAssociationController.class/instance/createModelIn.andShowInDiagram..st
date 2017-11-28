construction
createModelIn: aTargetController andShowInDiagram: aDiagramController
	| sourceProp targetProp |
	self model: self createModel.
	(sourceProp := OPUMLProperty new)
		owningClass: aTargetController model;
		name: sourceController model name uncapitalized;
		type: sourceController model.
	(targetProp := OPUMLProperty new)
		owningClass: sourceController model;
		name: aTargetController model name uncapitalized;
		type: aTargetController model.
	model memberEnds
		add: sourceProp;
		add: targetProp.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController.
	model memberEnds
		do: [ :each | 
			| subCtrl |
			subCtrl := aDiagramController newControllerFor: each.
			aDiagramController addController: subCtrl.
			subCtrl showInDiagram: aDiagramController ]