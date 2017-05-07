tests
testAllShowableElementsClassesWithAssociations
	| model child parent comment |
	child := OPUMLClass new.
	parent := OPUMLClass new.
	child
		generalizations:
			{OPUMLGeneralization new
				general: parent;
				specific: child}.
	(comment := OPUMLComment new) annotatedElements: child.
	child ownedComments: {comment}.
	(model := OPUMLModel new)
		packagedElements:
			{child.
			parent}.
	self
		assert: (controller allShowableElementsInModel: model)
		equals:
			{child.
			parent.
			"comment.
			child generalizations first"}