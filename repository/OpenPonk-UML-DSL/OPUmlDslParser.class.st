"
I am a public interface for UML DSL Parser.

!! Example:

[[[
DCUmlDslParser parse: '
Product {
	name : String
	price : Float
}
Category {
	name : String
}
Category[*] categories --- products Product[*];
'
]]]
"
Class {
	#name : 'OPUmlDslParser',
	#superclass : 'Object',
	#category : 'OpenPonk-UML-DSL-Parser',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Parser'
}

{ #category : 'parsing' }
OPUmlDslParser class >> parse: aString [
	^ self new parse: aString
]

{ #category : 'parsing' }
OPUmlDslParser >> normalize: aString [
	^ (aString trim lines collect: #trim) joinUsing: String cr
]

{ #category : 'parsing' }
OPUmlDslParser >> parse: aString [
	^ self replaceModel: MooseModel new withStatements: (self parseStatements: aString)
]

{ #category : 'parsing' }
OPUmlDslParser >> parseStatements: aString [
	^ OPUmlDslBuilder new parse: (self normalize: aString)
]

{ #category : 'parsing' }
OPUmlDslParser >> parseStatements: aString into: aModel [
	self replaceModel: aModel withStatements: (self parseStatements: aString)
]

{ #category : 'parsing' }
OPUmlDslParser >> replaceModel: aModel withStatements: statements [
	| classes |
	classes := (statements select: #isClass thenCollect: [ :each | each name -> each ])
		asOrderedDictionary.
	statements
		select: #isBinaryAssociation
		thenDo:
			[ :each | 
			classes
				at: each source name
				ifPresent: [ :source | each source: source ]
				ifAbsent: [ classes at: each source name put: each source ].
			classes
				at: each target name
				ifPresent: [ :target | each target: target ]
				ifAbsent: [ classes at: each target name put: each target ] ].
	statements
		select: #isInheritance
		thenDo:
			[ :each | 
			classes
				at: each subclass name
				ifPresent: [ :source | each subclass: source ]
				ifAbsent: [ classes at: each subclass name put: each subclass ].
			classes
				at: each superclass name
				ifPresent: [ :target | each superclass: target ]
				ifAbsent: [ classes at: each superclass name put: each superclass ] ].
	aModel entityStorage removeAll.
	aModel addAll: classes.
	aModel addAll: (statements select: [:each | each isBinaryAssociation | each isInheritance ]).
	^ aModel
]
