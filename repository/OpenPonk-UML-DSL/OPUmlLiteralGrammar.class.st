"
I am a grammar for LiteralSpecifications.

!! Reference
See UML 8.2.4 Literals Notation

!! Todo
<decimal>
<real>
"
Class {
	#name : #OPUmlLiteralGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'natural'
	],
	#category : 'OpenPonk-UML-DSL-Grammar'
}

{ #category : #'grammar-literals' }
OPUmlLiteralGrammar >> natural [
	^ #digit asParser plus flatten trim ==> [ :nodes | nodes asNumber ]
]

{ #category : #accessing }
OPUmlLiteralGrammar >> start [
	^ natural end
]
