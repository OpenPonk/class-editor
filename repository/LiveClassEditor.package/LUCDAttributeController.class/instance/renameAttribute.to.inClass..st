as yet unclassified
renameAttribute: oldName to: newName inClass: aClassName
	(RBRenameInstanceVariableRefactoring
		rename: oldName
		to: newName
		in: aClassName asClass
		renameAccessors: true) execute