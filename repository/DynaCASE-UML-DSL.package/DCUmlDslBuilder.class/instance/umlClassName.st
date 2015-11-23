accessing
umlClassName
	^ (self dependencyAt: DCUmlClassBuilder) dslName ==> [ :nodes | nodes second ]