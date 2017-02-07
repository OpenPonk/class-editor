transforming - meta
defaultMethodSourceFor: anAttribute
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}_default
	^ {2}'
				format:
					{anAttribute name.
					anAttribute defaultValue valueExpression})