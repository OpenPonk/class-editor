removing
removeModel
	| owner ownerController |
	ownerController := self diagramController.
	owner := ownerController model.
	self remove.
	owner packagedElements remove: self model.
	[ self model memberEnds isNotEmpty ]
		whileTrue: [ ownerController
				controllerForModel:
					(self model memberEnds anyOne
						association: nil;
						owningClass: nil;
						owningAssociation: nil;
						yourself)
				ifFound: [ :ctrl | ctrl removeModel ] ]