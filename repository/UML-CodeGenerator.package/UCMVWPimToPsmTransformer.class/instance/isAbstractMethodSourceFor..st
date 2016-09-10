transforming - meta
isAbstractMethodSourceFor: aClass
	^ FAMIXSourceTextAnchor new
		source:
			('isAbstract
	^ self = {1}' format: {aClass name})