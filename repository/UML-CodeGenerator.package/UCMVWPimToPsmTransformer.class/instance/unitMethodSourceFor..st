transforming - meta
unitMethodSourceFor: anAttribute
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}_unit
	^ ''{2}'''
				format:
					{anAttribute name.
					anAttribute unit})