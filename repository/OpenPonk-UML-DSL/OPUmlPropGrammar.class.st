"
I am a base class for operations and properties having some convenience methods.
"
Class {
	#name : #OPUmlPropGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'visibility',
		'type',
		'multiplicity',
		'symbol',
		'multiplicityRange',
		'prefix'
	],
	#category : 'OpenPonk-UML-DSL-Grammar'
}

{ #category : #accessing }
OPUmlPropGrammar class >> dependencies [
	^ {OPUmlLiteralGrammar.
	OPUmlMultiplicityGrammar}
]

{ #category : #testing }
OPUmlPropGrammar class >> isAbstract [
	^ self = OPUmlPropGrammar
]

{ #category : #grammar }
OPUmlPropGrammar >> multiplicity [
	^ (($[ asParser , multiplicityRange , $] asParser) ==> [ :nodes | nodes second ]) optional
]

{ #category : #grammar }
OPUmlPropGrammar >> multiplicityRange [
	^ (self dependencyAt: OPUmlMultiplicityGrammar) multiplicityRange
]

{ #category : #grammar }
OPUmlPropGrammar >> prefix [
	^ ($/ asParser / $_ asParser) star
]

{ #category : #grammar }
OPUmlPropGrammar >> symbol [
	^ (#word asParser / $_ asParser) plus flatten trim
]

{ #category : #grammar }
OPUmlPropGrammar >> type [
	^ symbol
]

{ #category : #grammar }
OPUmlPropGrammar >> visibility [
	^ $+ asParser / $- asParser / $# asParser / $~ asParser
]
