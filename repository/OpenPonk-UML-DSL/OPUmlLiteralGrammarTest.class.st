Class {
	#name : #OPUmlLiteralGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #accessing }
OPUmlLiteralGrammarTest >> parserClass [
	^ OPUmlLiteralGrammar
]

{ #category : #tests }
OPUmlLiteralGrammarTest >> testNatural [
	self parse: '123' rule: #natural
]
