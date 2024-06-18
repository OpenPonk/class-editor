Class {
	#name : 'OPUmlMethodBuilderTest',
	#superclass : 'OPUmlOperationGrammarTest',
	#category : 'OpenPonk-UML-DSL-Tests',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Tests'
}

{ #category : 'asserting' }
OPUmlMethodBuilderTest >> assertModel: anActual equals: anExpected [
	^ self
		assert: (OPUmlModelComparator new model: anActual equals: anExpected)
		description: [ self comparingStringBetween: anActual and: anExpected ]
]

{ #category : 'instance creation' }
OPUmlMethodBuilderTest >> operationWithParameter [
	^ (FAMIXMethod named: 'op')
		addParameter: (FAMIXParameter named: 'arg' type: (FAMIXClass named: 'Object'));
		yourself
]

{ #category : 'instance creation' }
OPUmlMethodBuilderTest >> operationWithParameters [
	| op p1 p2 |
	op := FAMIXMethod named: 'op'.
	p1 := FAMIXParameter named: 'first' type: (FAMIXClass named: 'String').
	(p2 := FAMIXParameter named: 'second' type: (FAMIXClass named: 'Number'))
		multiplicity: (OPFAMIXMultiplicity lower: 2 upper: 5).
	op addParameter: p1.
	op addParameter: p2.
	^ op
]

{ #category : 'accessing' }
OPUmlMethodBuilderTest >> parserClass [
	^ OPUmlMethodBuilder
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testAbstract [
	self parse: '/op()' rule: #operation.
	self assert: result isAbstract
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testOpName [
	self parse: 'op' rule: #opName.
	self assert: result equals: 'op'
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testOpName2 [
	self parse: 'op:name:' rule: #opName.
	self assert: result equals: 'op:name:'
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testOperation [
	self parse: 'op()' rule: #operation.
	self assert: result class equals: FAMIXMethod.
	self deny: result isStatic.
	self deny: result isAbstract.
	self assert: result name equals: 'op'.
	self assert: result parameters size equals: 0.
	self assert: result declaredType equals: nil
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testOperationWithMultiplicity [
	self parse: 'op(): String[2..*]' rule: #operation.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 2.
	self assert: result multiplicity upper equals: OPUnlimitedNatural max
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testOperationWithParameter [
	self parse: 'op(arg)' rule: #operation.
	self assertModel: result equals: self operationWithParameter
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testOperationWithParameters [
	self parse: 'op(first: String, second: Number[2..5])' rule: #operation.
	self assertModel: result equals: self operationWithParameters
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testOperationWithType [
	self parse: 'op(): String' rule: #operation.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testParameter [
	self parse: 'param : String' rule: #parameter.
	self assert: result class equals: FAMIXParameter.
	self assert: result name equals: 'param'.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testParameterWithMultiplicity [
	self parse: 'param : String[2..3]' rule: #parameter.
	self assert: result class equals: FAMIXParameter.
	self assert: result name equals: 'param'.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 2.
	self assert: result multiplicity upper equals: 3
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testStatic [
	self parse: '_op()' rule: #operation.
	self assert: result class equals: FAMIXMethod.
	self assert: result name equals: 'op'.
	self assert: result isStatic
]

{ #category : 'tests' }
OPUmlMethodBuilderTest >> testVisibility [
	OPUmlVisibilityKind symbolMapping
		keysAndValuesDo: [ :symbol :literal | 
			self parse: symbol asString rule: #visibility.
			self assert: result equals: literal ].
	self fail: '*' rule: #visibility
]
