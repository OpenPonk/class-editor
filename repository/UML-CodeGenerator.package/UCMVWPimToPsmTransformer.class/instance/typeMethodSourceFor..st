transforming - meta
typeMethodSourceFor: anAttribute
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}_type
	^ {2}'
				format:
					{anAttribute name.
					anAttribute declaredType name})