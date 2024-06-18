Class {
	#name : 'OPUmlLiteralGrammarTest',
	#superclass : 'PPCompositeParserTest',
	#category : 'OpenPonk-UML-DSL-Tests',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPUmlLiteralGrammarTest >> parserClass [
	^ OPUmlLiteralGrammar
]

{ #category : 'tests' }
OPUmlLiteralGrammarTest >> testNatural [
	self parse: '123' rule: #natural
]
