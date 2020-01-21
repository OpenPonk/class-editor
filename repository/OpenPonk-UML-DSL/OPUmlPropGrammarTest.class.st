Class {
	#name : #OPUmlPropGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #testing }
OPUmlPropGrammarTest class >> isAbstract [
	^ self = OPUmlPropGrammarTest
]

{ #category : #tests }
OPUmlPropGrammarTest >> testMultiplicity [
	self parse: '' rule: #multiplicity.
	self parse: '[1]' rule: #multiplicity
]

{ #category : #tests }
OPUmlPropGrammarTest >> testPrefix [
	self parse: '/' rule: #prefix.
	self parse: '_' rule: #prefix.
	self parse: '/_' rule: #prefix.
	self parse: '_/' rule: #prefix
]

{ #category : #tests }
OPUmlPropGrammarTest >> testSymbol [
	self parse: 'symbol' rule: #symbol
]

{ #category : #tests }
OPUmlPropGrammarTest >> testType [
	self parse: 'symbol' rule: #type
]

{ #category : #tests }
OPUmlPropGrammarTest >> testVisibility [
	self parse: '+' rule: #visibility.
	self parse: '-' rule: #visibility.
	self parse: '#' rule: #visibility.
	self parse: '~' rule: #visibility
]
