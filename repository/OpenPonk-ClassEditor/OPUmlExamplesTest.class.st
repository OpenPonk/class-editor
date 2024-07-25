Class {
	#name : 'OPUmlExamplesTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlExamplesTest >> testAll [

	OPUmlExamples class selectors
		select: [ :each |
		(each beginsWith: 'open') and: [ (each includes: $:) not ] ]
		thenDo: [ :each | self testExample: each ]
]

{ #category : 'tests' }
OPUmlExamplesTest >> testExample: anExampleSelector [
	| window |
	self assert: anExampleSelector isSymbol.
	self assert: (OPUmlExamples class selectors includes: anExampleSelector).
	window := OPUmlExamples perform: anExampleSelector.
	self assert: (window isKindOf: OPWorkbench).
	window delete
]
