visitor
visitOwnedAttribute: anOwnedAttribute
	elements
		at: anOwnedAttribute xmiId
		put: [ | prop |
			anOwnedAttribute @ #association
				ifEmpty: [ (prop := FAMIXAttribute new) name: anOwnedAttribute @ #name.
					prop mooseModel: (self elementAt: anOwnedAttribute parent xmiId) mooseModel.
					(self elementAt: anOwnedAttribute parent xmiId) addAttribute: prop ]
				ifNotEmpty: [ | assoc isSource assocElement |
					(prop := DCFAMIXProperty new) name: anOwnedAttribute @ #name.
					anOwnedAttribute @ #aggregation ifNotEmpty: [ :agg | prop aggregation: agg ].
					assoc := self elementAt: anOwnedAttribute @ #association.
					assocElement := anOwnedAttribute parent parent elements
						detect: [ :each | each xmiId = (anOwnedAttribute @ #association) ].
					isSource := assocElement elements first @ #xmi:idref = anOwnedAttribute xmiId.
					prop association: assoc.
					isSource
						ifTrue: [ assoc instVarNamed: #sourceEnd put: prop ]
						ifFalse: [ assoc instVarNamed: #targetEnd put: prop ] ].
			prop ].
	self visitChildren: anOwnedAttribute