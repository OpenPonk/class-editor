transforming - accessors
eagerGetterSourceFor: anAttribute
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}
	^ {1}'
				format:
					{anAttribute name.
					self getterPragmaFor: anAttribute})