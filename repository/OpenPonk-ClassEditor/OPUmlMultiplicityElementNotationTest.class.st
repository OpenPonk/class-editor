Class {
	#name : #OPUmlMultiplicityElementNotationTest,
	#superclass : #TestCase,
	#instVars : [
		'multiplicity'
	],
	#category : 'OpenPonk-ClassEditor-Tests'
}

{ #category : #'instance creation' }
OPUmlMultiplicityElementNotationTest >> multiplicityOn: aPair [
	| el |
	el := OPUMLMultiplicityElement new.
	aPair first ifNotNil: [ el lowerValue: (OPUMLLiteralInteger new value: aPair first) ].
	aPair second
		ifNotNil: [ el upperValue: (OPUMLLiteralUnlimitedNatural new value: aPair second) ].
	^ el
]

{ #category : #tests }
OPUmlMultiplicityElementNotationTest >> testDifferentLowerUpper [
	multiplicity := OPUMLMultiplicityElement new.
	multiplicity lowerValue: (OPUMLLiteralInteger new value: 2).
	multiplicity upperValue: (OPUMLLiteralUnlimitedNatural new value: 2).
]

{ #category : #tests }
OPUmlMultiplicityElementNotationTest >> testNoUpper [
	self assert: (self multiplicityOn: #(1 nil)) notationMultiplicityRange equals: ''
]

{ #category : #tests }
OPUmlMultiplicityElementNotationTest >> testNoUpperZero [
	self assert: (self multiplicityOn: #(0 nil)) notationMultiplicityRange equals: '0..1'
]

{ #category : #tests }
OPUmlMultiplicityElementNotationTest >> testSameLowerUpper [
	self assert: (self multiplicityOn: #(3 3)) notationMultiplicityRange equals: '3'
]

{ #category : #tests }
OPUmlMultiplicityElementNotationTest >> testSameLowerUpperOne [
	self assert: (self multiplicityOn: #(1 1)) notationMultiplicityRange equals: ''
]

{ #category : #tests }
OPUmlMultiplicityElementNotationTest >> testUpperUnlimited [
	self assert: (self multiplicityOn: #(4 '*')) notationMultiplicityRange equals: '4..*'
]

{ #category : #tests }
OPUmlMultiplicityElementNotationTest >> testZeroUnlimited [
	self assert: (self multiplicityOn: #(0 '*')) notationMultiplicityRange equals: '*'
]
