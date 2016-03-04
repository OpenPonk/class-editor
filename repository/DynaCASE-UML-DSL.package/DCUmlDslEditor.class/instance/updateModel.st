event handling
updateModel
	model ifNil: [ model := MooseModel new ].
	parser parseStatements: editor text asString into: model.
	model announcer announce: (DCModelContentReplaced model: model)