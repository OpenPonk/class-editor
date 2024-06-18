Class {
	#name : 'OPUmlAttributeBuilderTest',
	#superclass : 'OPUmlPropertyGrammarTest',
	#category : 'OpenPonk-UML-DSL-Tests',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPUmlAttributeBuilderTest >> parserClass [
	^ OPUmlAttributeBuilder
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testDefaultValue [
	self parse: '= 10' rule: #defaultValue.
	self assert: result class equals: OPFAMIXValueSpecification.
	self assert: result valueExpression equals: '10'
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testMultiplicity [
	self parse: '' rule: #multiplicity.
	self assert: result class equals: OPFAMIXMultiplicity.
	self assert: result lower equals: 1.
	self assert: result upper equals: 1
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testMultiplicity1 [
	self parse: '[3]' rule: #multiplicity.
	self assert: result lower equals: 3.
	self assert: result upper equals: 3
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testMultiplicity2 [
	self parse: '[*]' rule: #multiplicity.
	self assert: result lower equals: 0.
	self assert: result upper equals: OPUnlimitedNatural max
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testMultiplicity3 [
	self parse: '[2..5]' rule: #multiplicity.
	self assert: result lower equals: 2.
	self assert: result upper equals: 5
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testMultiplicity4 [
	self parse: '[2..*]' rule: #multiplicity.
	self assert: result lower equals: 2.
	self assert: result upper equals: OPUnlimitedNatural max
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testProperty [
	self parse: 'prop' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'prop'.
	self assert: result declaredType equals: nil.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testPropertyWithDefaultValue [
	self parse: 'prop : Integer[4] = #(1 2 3 4)' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'prop'.
	self assert: result declaredType name equals: 'Integer'.
	self assert: result multiplicity lower equals: 4.
	self assert: result multiplicity upper equals: 4.
	self assert: result defaultValue valueExpression equals: '#(1 2 3 4)'
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testPropertyWithDefaultValue2 [
	self parse: 'attr : String = ''hello''' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'attr'.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1.
	self assert: result defaultValue valueExpression equals: '''hello'''
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testPropertyWithMultiplicity [
	self parse: 'prop: String[2..3]' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'prop'.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 2.
	self assert: result multiplicity upper equals: 3
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testPropertyWithType [
	self parse: 'prop: String' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'prop'.
	self assert: result declaredType name equals: 'String'.
	self assert: result multiplicity lower equals: 1.
	self assert: result multiplicity upper equals: 1
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testStatic [
	self parse: '_prop' rule: #property.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'prop'.
	self assert: result isStatic
]

{ #category : 'tests' }
OPUmlAttributeBuilderTest >> testVisibility [
	OPUmlVisibilityKind symbolMapping
		keysAndValuesDo: [ :symbol :literal | 
			self parse: symbol asString rule: #visibility.
			self assert: result equals: literal ].
	self fail: '*' rule: #visibility
]
