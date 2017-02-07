accessing
umlClassName
	^ (self dependencyAt: OPUmlClassBuilder) dslName ==> [ :nodes | nodes second ]