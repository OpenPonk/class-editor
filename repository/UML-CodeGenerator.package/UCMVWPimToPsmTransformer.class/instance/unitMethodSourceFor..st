transforming - meta
unitMethodSourceFor: anAttribute
	^ FAMIXSourceTextAnchor new
		source:
			('{1}_unit
	^ ''{2}'''
				format:
					{anAttribute name.
					anAttribute unit})