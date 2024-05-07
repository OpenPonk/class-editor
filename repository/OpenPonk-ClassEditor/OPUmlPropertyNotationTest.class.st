Class {
	#name : 'OPUmlPropertyNotationTest',
	#superclass : 'TestCase',
	#instVars : [
		'property'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testProperty [
	(property := OPUMLProperty new) name: 'op'.
	self assert: property notationString equals: 'op'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyDefaultValue [
	(property := OPUMLProperty new)
		name: 'op';
		defaultValue: (OPUMLOpaqueExpression new bodies: {'abc'}).
	self assert: property notationString equals: 'op = abc'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyDerived [
	(property := OPUMLProperty new)
		name: 'op';
		isDerived: true.
	self assert: property notationString equals: '/op'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyModifiers [
	(property := OPUMLProperty new)
		name: 'op';
		isReadOnly: true;
		isOrdered: true.
	self assert: property notationString equals: 'op {readOnly, ordered}'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyNilName [
	property := OPUMLProperty new.
	self assert: property notationString equals: ''
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyType [
	(property := OPUMLProperty new)
		name: 'op';
		type: (OPUMLClass new name: 'Thing').
	self assert: property notationString equals: 'op : Thing'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyTypeMultiplicity [
	(property := OPUMLProperty new)
		name: 'op';
		type: (OPUMLClass new name: 'Thing');
		lowerValue: (OPUMLLiteralInteger new value: 12);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	self assert: property notationString equals: 'op : Thing[12..*]'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyUniqueMultivalued [
	"isUnique has no semantic effect on non-multivalued element (specs)"

	(property := OPUMLProperty new)
		name: 'op';
		isUnique: false;
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	self assert: property notationString equals: 'op[1..*] {nonunique}'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyUniqueMultivalued2 [
	"isUnique has no semantic effect on non-multivalued element (specs)"

	(property := OPUMLProperty new)
		name: 'op';
		isUnique: false.
	self assert: property notationString equals: 'op'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyUniqueNonMultivalued [
	"isUnique has no semantic effect on non-multivalued element (specs)"

	(property := OPUMLProperty new)
		name: 'op';
		isUnique: true.
	self assert: property notationString equals: 'op'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyUniqueNonMultivalued2 [
	"isUnique has no semantic effect on non-multivalued element (specs)"

	(property := OPUMLProperty new)
		name: 'op';
		isUnique: false.
	self assert: property notationString equals: 'op'
]

{ #category : 'tests' }
OPUmlPropertyNotationTest >> testPropertyVisibility [
	(property := OPUMLProperty new)
		name: 'op';
		visibility: OPUMLVisibilityKind protected.
	self assert: property notationString equals: '# op'
]
