Class {
	#name : #OPUmlMultiplicityGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #accessing }
OPUmlMultiplicityGrammarTest >> parserClass [
	^ OPUmlMultiplicityGrammar
]

{ #category : #tests }
OPUmlMultiplicityGrammarTest >> testLower [
	self parse: '123' rule: #lower
]

{ #category : #'as yet unclassified' }
OPUmlMultiplicityGrammarTest >> testMultiplicityRange [
	self parse: '1..2' rule: #multiplicityRange.
	self parse: '1' rule: #multiplicityRange.
	self parse: '*' rule: #multiplicityRange
]

{ #category : #'as yet unclassified' }
OPUmlMultiplicityGrammarTest >> testUpper [
	self parse: '123' rule: #upper.
	self parse: '*' rule: #upper
]
