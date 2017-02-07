transforming - accessors
setterSourceFor: anAttribute
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}: {2}
	{1} = {2} ifTrue: [ ^ self ]. "for optimization"
	{1} := {2}.
	self changed'
				format:
					{anAttribute name.
					self indefiniteTypeNameFor: anAttribute})