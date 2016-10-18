as yet unclassified
renameAttribute: oldName to: newName inClass: aClassName
	(RBRenameInstanceVariableRefactoring
		rename: oldName
		to: newName
		in: aClassName asClass
		renameAccessors: true) execute.
	self model parentType methods
		detect: [ :each | each name = oldName ]
		ifFound: [ :each | 
			each name: newName.
			(self diagramController controllerForModel: each) refreshFigure ].
	self model parentType methods
		detect: [ :each | each name = (oldName , ':') ]
		ifFound: [ :each | 
			each name: newName , ':'.
			(self diagramController controllerForModel: each) refreshFigure ]