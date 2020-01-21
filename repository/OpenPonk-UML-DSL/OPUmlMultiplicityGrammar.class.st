"
I am a grammar for LiteralSpecifications.

!! Reference
See UML 7.5.4 Types and Multiplicity Notation.

!! Notes
1 == 1..1
* == 0..*

!! TODO
<order-designator>
<uniqueness-designator>
"
Class {
	#name : #OPUmlMultiplicityGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'lower',
		'upper',
		'multiplicityRange',
		'multiplicity',
		'naturalLiteral'
	],
	#category : 'OpenPonk-UML-DSL-Grammar'
}

{ #category : #accessing }
OPUmlMultiplicityGrammar class >> dependencies [
	^ {OPUmlLiteralGrammar}
]

{ #category : #grammar }
OPUmlMultiplicityGrammar >> lower [
	^ naturalLiteral
]

{ #category : #grammar }
OPUmlMultiplicityGrammar >> multiplicity [
	^ multiplicityRange
]

{ #category : #grammar }
OPUmlMultiplicityGrammar >> multiplicityRange [
	^ ((lower , '..' asParser) ==> [ :n | n first ]) optional , upper
]

{ #category : #grammar }
OPUmlMultiplicityGrammar >> naturalLiteral [
	^ (self dependencyAt: OPUmlLiteralGrammar) natural
]

{ #category : #accessing }
OPUmlMultiplicityGrammar >> start [
	^ multiplicity end
]

{ #category : #grammar }
OPUmlMultiplicityGrammar >> upper [
	^ naturalLiteral / $* asParser
]
