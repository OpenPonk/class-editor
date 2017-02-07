visitor
visitOwnedEnd: anOwnedEnd
	elements
		at: anOwnedEnd xmiId
		put: [ | isSource prop assoc |
			assoc := self elementAt: anOwnedEnd @ #association.
			isSource := anOwnedEnd parent elements first @ #xmi:idref = anOwnedEnd xmiId.
			(prop := OPFAMIXProperty new)
				name: anOwnedEnd @ #name;
				instVarNamed: #mooseID put: anOwnedEnd xmiId.
			anOwnedEnd @ #aggregation ifNotEmpty: [ :agg | prop aggregation: agg ].
			prop association: assoc.
			isSource
				ifTrue: [ assoc instVarNamed: #sourceEnd put: prop ]
				ifFalse: [ assoc instVarNamed: #targetEnd put: prop ].
			prop ].
	self visitChildren: anOwnedEnd