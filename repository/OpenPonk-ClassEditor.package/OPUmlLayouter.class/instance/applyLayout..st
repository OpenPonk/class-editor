ui hooks
applyLayout: aThreeArgBlock
	| classifiers classes packages hierarchy associations packageImports boxes links |
	classifiers := packagedElements
		select: [ :each | (each oclIsKindOf: #Class) | (each oclIsKindOf: #DataType) ].
	classes := classifiers select: [ :each | each oclIsKindOf: #Class ].
	packages := packagedElements select: [ :each | each oclIsKindOf: #Package ].
	hierarchy := (classifiers flatCollect: #generalizations)
		, (classes flatCollect: #extensions).
	associations := (packagedElements select: [ :each | each oclIsKindOf: #Association ])
		\ hierarchy.
	packageImports := packages flatCollect: #packageImports.
	boxes := classifiers , packages.
	links := associations , packageImports.
	aThreeArgBlock
		value: (self figuresFor: boxes)
		value: (self figuresFor: hierarchy)
		value: (self figuresFor: links).
	self updateView