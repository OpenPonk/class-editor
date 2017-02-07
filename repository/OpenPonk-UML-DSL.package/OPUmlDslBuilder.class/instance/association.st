accessing
association
	^ ((self dependencyAt: OPUmlAssociationBuilder) association , $; asParser)
		==> [ :nodes | nodes first ]