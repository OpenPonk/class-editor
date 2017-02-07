transforming - meta
isAbstractMethodSourceFor: aClass
	^ OPUmlSingleOpaqueBehavior
		body:
			('isAbstract
	^ self = {1}' format: {aClass name})