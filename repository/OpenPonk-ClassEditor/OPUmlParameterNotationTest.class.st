Class {
	#name : 'OPUmlParameterNotationTest',
	#superclass : 'TestCase',
	#instVars : [
		'parameter'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlParameterNotationTest >> testParameter [
	(parameter := OPUMLParameter new) name: 'param'.
	self assert: parameter notationString equals: 'param'
]

{ #category : 'tests' }
OPUmlParameterNotationTest >> testParameterDirectionIn [
	(parameter := OPUMLParameter new)
		name: 'param';
		direction: OPUMLParameterDirectionKind in.
	self assert: parameter notationString equals: 'param'
]

{ #category : 'tests' }
OPUmlParameterNotationTest >> testParameterDirectionInOut [
	(parameter := OPUMLParameter new)
		name: 'param';
		direction: OPUMLParameterDirectionKind inout.
	self assert: parameter notationString equals: 'inout param'
]

{ #category : 'tests' }
OPUmlParameterNotationTest >> testParameterDirectionOut [
	(parameter := OPUMLParameter new)
		name: 'param';
		direction: OPUMLParameterDirectionKind out.
	self assert: parameter notationString equals: 'out param'
]

{ #category : 'tests' }
OPUmlParameterNotationTest >> testParameterName [
	(parameter := OPUMLParameter new) name: 'param'.
	self assert: parameter notationString equals: 'param'
]

{ #category : 'tests' }
OPUmlParameterNotationTest >> testParameterTypeExpression [
	(parameter := OPUMLParameter new)
		name: 'param';
		type: (OPUMLClass new name: 'String').
	self assert: parameter notationString equals: 'param : String'
]

{ #category : 'tests' }
OPUmlParameterNotationTest >> testParameterTypeExpressionWithMultiplicity [
	(parameter := OPUMLParameter new)
		name: 'param';
		type: (OPUMLClass new name: 'String');
		lowerValue: (OPUMLLiteralInteger new value: 3);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	self assert: parameter notationString equals: 'param : String[3..*]'
]
