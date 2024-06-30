Class {
	#name : 'OPUmlElementControllerTest',
	#superclass : 'OPAbstractElementControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'testing' }
OPUmlElementControllerTest class >> isAbstract [
	^ self = OPUmlElementControllerTest
]

{ #category : 'accessing' }
OPUmlElementControllerTest >> allElements [

	^ self allElementsOf: diagramController model
]

{ #category : 'as yet unclassified' }
OPUmlElementControllerTest >> allElementsOf: aPackage [

	| elements |
	elements := Set new.
	elements addAll: (aPackage packagedElements reject: [ :each |
			 each oclIsKindOf: #Association ]).
	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			elements addAll: (self allElementsOf: each).
			each packageImports do: [ :import |
				elements add: import importedPackage.
				elements add: import ] ].
	aPackage packagedElements
		select: [ :each |
			(each isKindOf: OPUMLClass) | (each isKindOf: OPUMLStereotype) ]
		thenDo: [ :each |
			each generalizations do: [ :gen |
				elements add: gen general.
				elements add: gen ].
			(each ownedAttributes select: [ :attr |
				 attr isKindOf: OPUMLProperty ]) do: [ :attr |
				elements add: attr.
				attr association ifNotNil: [ elements add: attr association ] ].
			(each ownedOperations select: [ :op | op isKindOf: OPUMLOperation ])
				do: [ :op | elements add: op ] ].
	aPackage packagedElements
		select: [ :each | each isKindOf: OPUMLStereotype ]
		thenDo: [ :each |
			each ownedAttributes
				select: [ :attr |
					attr association isNotNil and: [
						attr association isKindOf: OPUMLExtension ] ]
				thenDo: [ :attr | elements add: attr type ] ].
	aPackage packagedElements
		select: [ :each | each isKindOf: OPUMLEnumeration ]
		thenDo: [ :each |
		each ownedLiterals do: [ :literal | elements add: literal ] ].
	^ elements
]

{ #category : 'accessing' }
OPUmlElementControllerTest >> diagramControllerClass [

	^ OPUmlPackageDiagramController
]

{ #category : 'accessing' }
OPUmlElementControllerTest >> diagramModelClass [

	^ OPUMLPackage
]
