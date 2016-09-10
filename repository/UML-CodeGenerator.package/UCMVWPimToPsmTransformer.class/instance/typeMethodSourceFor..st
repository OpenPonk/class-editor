transforming - meta
typeMethodSourceFor: anAttribute
	^ FAMIXSourceTextAnchor new
		source:
			('{1}_type
	^ {2}'
				format:
					{anAttribute name.
					anAttribute declaredType name})