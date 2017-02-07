visitor
visitMemberEnd: aMemberEnd
	"let's try to handle it from ownedEnd/ownedAttribute"
	"elements
		at: aMemberEnd
		put: [ | assoc |
			assoc := self elementAt: aMemberEnd parent xmiId.
			aMemberEnd parent elements second = aMemberEnd
				ifTrue: [ (self elementAt: aMemberEnd @ #xmi:idref) association: assoc.
					assoc instVarNamed: #sourceEnd put: (self elementAt: aMemberEnd @ #xmi:idref).
					assoc source: assoc sourceEnd declaredType ]
				ifFalse: [ (self elementAt: aMemberEnd @ #xmi:idref) association: assoc.
					assoc instVarNamed: #targetEnd put: (self elementAt: aMemberEnd @ #xmi:idref).
					assoc target: assoc targetEnd declaredType ].
			nil ]"