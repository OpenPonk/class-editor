construction
createModelIn: aTargetController andShowInDiagram: aDiagramController
	| sourceOwnedProp extensionOwnedProp |
	self model: self createModel.
	(sourceOwnedProp := OPUMLProperty new)
		owningClass: sourceController model;
		name: 'base_' , aTargetController model name;
		type: aTargetController model.
	(extensionOwnedProp := OPUMLExtensionEnd new)
		name: 'extension_' , sourceController model name;
		type: sourceController model.
	model ownedEnd: extensionOwnedProp.
	model memberEnds
		add: sourceOwnedProp;
		add: extensionOwnedProp.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController.
	{sourceOwnedProp}
		do: [ :each | 
			| subCtrl |
			subCtrl := aDiagramController newControllerFor: each.
			aDiagramController addController: subCtrl.
			subCtrl showInDiagram: aDiagramController ]