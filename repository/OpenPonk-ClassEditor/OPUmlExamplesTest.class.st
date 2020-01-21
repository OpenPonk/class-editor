Class {
	#name : #OPUmlExamplesTest,
	#superclass : #TestCase,
	#category : 'OpenPonk-ClassEditor-Tests'
}

{ #category : #tests }
OPUmlExamplesTest >> testAll [
	OPUmlExamples class selectors
		select: [ :each | each beginsWith: 'example' ]
		thenDo: [ :each | self testExample: each ]
]

{ #category : #tests }
OPUmlExamplesTest >> testExample: anExampleSelector [
	| window |
	self assert: anExampleSelector isSymbol.
	self assert: (OPUmlExamples class selectors includes: anExampleSelector).
	window := OPUmlExamples perform: anExampleSelector.
	self assert: (window isKindOf: OPWorkbench).
	window delete
]
