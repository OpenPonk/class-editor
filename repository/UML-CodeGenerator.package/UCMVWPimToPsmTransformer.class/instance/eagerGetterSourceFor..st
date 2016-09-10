transforming - accessors
eagerGetterSourceFor: anAttribute
	^ FAMIXSourceTextAnchor new
		source:
			('{1}
	^ {1}'
				format:
					{anAttribute name.
					self getterPragmaFor: anAttribute})