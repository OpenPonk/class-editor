accessing
association
	^ ((self dependencyAt: DCUmlAssociationBuilder) association , $; asParser)
		==> [ :nodes | nodes first ]