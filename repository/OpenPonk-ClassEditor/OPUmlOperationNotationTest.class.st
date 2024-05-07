Class {
	#name : 'OPUmlOperationNotationTest',
	#superclass : 'TestCase',
	#instVars : [
		'operation'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlOperationNotationTest >> testOperation [
	(operation := OPUMLOperation new) name: 'op'.
	self assert: operation notationString equals: 'op()'
]

{ #category : 'tests' }
OPUmlOperationNotationTest >> testOperationNilName [
	operation := OPUMLOperation new.
	self assert: operation notationString equals: '()'
]

{ #category : 'tests' }
OPUmlOperationNotationTest >> testOperationParameters [
	(operation := OPUMLOperation new)
		name: 'op';
		ownedParameters:
			{OPUMLParameter new name: 'first'.
			OPUMLParameter new name: 'second'}.
	self assert: operation notationString equals: 'op(first, second)'
]

{ #category : 'tests' }
OPUmlOperationNotationTest >> testOperationReturnType [
	(operation := OPUMLOperation new)
		name: 'op';
		ownedParameters:
			{OPUMLParameter new
				type: (OPUMLClass new name: 'Thing');
				direction: OPUMLParameterDirectionKind return}.
	self assert: operation notationString equals: 'op() : Thing'
]

{ #category : 'tests' }
OPUmlOperationNotationTest >> testOperationReturnTypeWithMultiplicity [
	(operation := OPUMLOperation new)
		name: 'op';
		ownedParameters:
			{OPUMLParameter new
				type: (OPUMLClass new name: 'Thing');
				direction: OPUMLParameterDirectionKind return;
				lowerValue: (OPUMLLiteralInteger new value: 2);
				upperValue: (OPUMLLiteralUnlimitedNatural new value: 6)}.
	self assert: operation notationString equals: 'op() : Thing[2..6]'
]

{ #category : 'tests' }
OPUmlOperationNotationTest >> testOperationVisibility [
	(operation := OPUMLOperation new)
		name: 'op';
		visibility: OPUMLVisibilityKind protected.
	self assert: operation notationString equals: '# op()'
]
