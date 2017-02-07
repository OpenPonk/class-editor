visitor
visitOwnedOperation: anElement
	elements
		at: anElement xmiId
		put: [ | method |
			(method := FAMIXMethod new)
				name: anElement @ #name;
				mooseModel: (self elementAt: anElement parent xmiId) mooseModel.
			anElement @ #isAbstract = 'true'
				ifTrue: [ method isAbstract: true ].
			anElement @ #isStatic = 'true'
				ifTrue: [ method isStatic: true ].
			(self elementAt: anElement parent xmiId) addMethod: method.
			method ].
	self visitChildren: anElement