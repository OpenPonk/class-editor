as yet unclassified
extractDefaultValueFromAccessor: aMethod
	| ast |
	ast := aMethod sourceAnchor pharoEntity ast.
	ast assignmentNodes
		ifNotEmptyDo: [ :nodes | self ensureDefaultValue: nodes first value value fromMethod: aMethod ]