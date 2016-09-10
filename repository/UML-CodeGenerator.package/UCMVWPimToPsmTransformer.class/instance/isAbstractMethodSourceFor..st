transforming - meta
isAbstractMethodSourceFor: aClass
	^ DCUmlSingleOpaqueBehavior
		body:
			('isAbstract
	^ self = {1}' format: {aClass name})