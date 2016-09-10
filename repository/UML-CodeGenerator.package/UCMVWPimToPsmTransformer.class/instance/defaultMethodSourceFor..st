transforming - meta
defaultMethodSourceFor: anAttribute
	^ DCUmlSingleOpaqueBehavior
		body:
			('{1}_default
	^ {2}'
				format:
					{anAttribute name.
					anAttribute defaultValue valueExpression})