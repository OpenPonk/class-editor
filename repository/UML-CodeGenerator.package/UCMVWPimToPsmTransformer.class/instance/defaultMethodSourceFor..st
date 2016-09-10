transforming - meta
defaultMethodSourceFor: anAttribute
	^ FAMIXSourceTextAnchor new
		source:
			('{1}_default
	^ {2}'
				format:
					{anAttribute name.
					anAttribute defaultValue valueExpression})