"
I am grammar for associations.
"
Class {
	#name : #OPUmlAssociationGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'multiplicityRange',
		'multiplicity',
		'association',
		'typeSymbol',
		'startSymbol',
		'endSymbol',
		'type',
		'umlClassName',
		'endName',
		'associationName',
		'leftEnd',
		'rightEnd'
	],
	#category : 'OpenPonk-UML-DSL-Grammar'
}

{ #category : #accessing }
OPUmlAssociationGrammar class >> dependencies [
	^ {OPUmlClassBuilder.
	OPUmlMultiplicityGrammar}
]

{ #category : #accessing }
OPUmlAssociationGrammar >> association [
	^ leftEnd , $- asParser , rightEnd , associationName optional
]

{ #category : #accessing }
OPUmlAssociationGrammar >> associationName [
	^ (#blank asParser star , $: asParser , #blank asParser star , endName)
		==> [ :nodes | nodes fourth ]
]

{ #category : #accessing }
OPUmlAssociationGrammar >> endName [
	^ #word asParser plus flatten
]

{ #category : #accessing }
OPUmlAssociationGrammar >> endSymbol [
	^ typeSymbol / '>' asParser
]

{ #category : #accessing }
OPUmlAssociationGrammar >> leftEnd [
	^ umlClassName , multiplicity trim , endName optional trim , startSymbol
]

{ #category : #grammar }
OPUmlAssociationGrammar >> multiplicity [
	^ (($[ asParser , multiplicityRange , $] asParser) ==> [ :nodes | nodes second ]) optional
]

{ #category : #grammar }
OPUmlAssociationGrammar >> multiplicityRange [
	^ (self dependencyAt: OPUmlMultiplicityGrammar) multiplicityRange
]

{ #category : #grammar }
OPUmlAssociationGrammar >> rightEnd [
	^ endSymbol trim
		,
			(((endName , #space asParser plus , umlClassName)
				==> [ :nodes | 
					{nodes first.
					nodes last} ]) / umlClassName) , multiplicity
]

{ #category : #accessing }
OPUmlAssociationGrammar >> start [
	^ association end
]

{ #category : #accessing }
OPUmlAssociationGrammar >> startSymbol [
	^ typeSymbol / '<' asParser
]

{ #category : #accessing }
OPUmlAssociationGrammar >> type [
	^ (startSymbol , $- asParser , endSymbol) trim
]

{ #category : #accessing }
OPUmlAssociationGrammar >> typeSymbol [
	^ $- asParser / '<>' asParser / '<*>' asParser
]

{ #category : #accessing }
OPUmlAssociationGrammar >> umlClassName [
	^ (self dependencyAt: OPUmlClassBuilder) dslName ==> [ :nodes | nodes second ]
]
