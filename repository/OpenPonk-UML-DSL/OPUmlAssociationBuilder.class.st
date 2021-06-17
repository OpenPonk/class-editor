"
<association> ::= <source-class> [ <multiplicity> ] [ <source-name> ]
<type>
[ <target-name> ] <target-class> [ <multiplicity> ]
[ ':' <association-name> ].

<type> ::= <start-symbol> [ '-' ]*  <end-symbol>
<start-symbol> ::= <type-symbol> | '<'
<end-symbol> ::= <type-symbol> | '>'
<type-symbol> ::=  '-' | '<>' | '<*>'
"
Class {
	#name : #OPUmlAssociationBuilder,
	#superclass : #OPUmlAssociationGrammar,
	#category : #'OpenPonk-UML-DSL-Builders'
}

{ #category : #accessing }
OPUmlAssociationBuilder >> association [
	^ super association
		==> [ :nodes | 
			| assoc |
			assoc := DCFAMIXBinaryAssociation new.
			assoc name: (nodes fourth ifNil: [ '' ]).
			nodes first second association: assoc.
			nodes third second association: assoc.
			assoc instVarNamed: #sourceEnd put: nodes first second.
			assoc instVarNamed: #targetEnd put: nodes third second.
			nodes first second
				declaredType: (FAMIXClass named: nodes first first);
				aggregation: nodes third third.
			nodes third second
				declaredType: (FAMIXClass named: nodes third first);
				aggregation: nodes first third.
			nodes first second association: assoc.
			nodes third second association: assoc.
			nodes first fourth = false & (nodes third fourth = true)
				ifTrue: [ assoc sourceEnd isNavigable: false ].
			nodes first fourth = true & (nodes third fourth = false)
				ifTrue: [ assoc targetEnd isNavigable: false ].
			assoc ]
]

{ #category : #accessing }
OPUmlAssociationBuilder >> endSymbol [
	^ super endSymbol
		==>
			[ :nodes | 
			nodes = '>'
				ifTrue: [ {DCUmlAggregationKind none.
					true} ]
				ifFalse: [ nodes ] ]
]

{ #category : #accessing }
OPUmlAssociationBuilder >> leftEnd [
	^ super leftEnd
		==> [ :nodes | 
			{nodes first.
			(DCFAMIXProperty new
				name: nodes third;
				multiplicity: nodes second).
			nodes fourth first.
			nodes fourth second} ]
]

{ #category : #accessing }
OPUmlAssociationBuilder >> multiplicity [
	^ super multiplicity trim
		==>
			[ :nodes | 
			| m |
			m := DCFAMIXMultiplicity new.
			nodes
				ifNotNil: [ 
					m
						lower: nodes first;
						upper: nodes second ].
			m ]
]

{ #category : #accessing }
OPUmlAssociationBuilder >> multiplicityRange [
	^ super multiplicityRange
		==>
			[ :nodes | 
			| min max |
			min := nodes first.
			max := nodes second.
			max = $*
				ifTrue: [ max := DCUnlimitedNatural max ].
			min
				ifNil: [ 
					min := max = DCUnlimitedNatural max
						ifTrue: [ 0 ]
						ifFalse: [ max ] ].
			Array with: min with: max ]
]

{ #category : #accessing }
OPUmlAssociationBuilder >> rightEnd [
	^ super rightEnd
		==> [ :n | 
			| nodes |
			nodes := Array
				with:
					(n second isArray
						ifTrue: [ n second second ]
						ifFalse: [ n second ])
				with: n third
				with:
					(n second isArray
						ifTrue: [ n second first ]
						ifFalse: [ nil ])
				with: n first.
			{nodes first.
			(DCFAMIXProperty new
				name: nodes third;
				multiplicity: nodes second).
			nodes fourth first.
			nodes fourth second} ]
]

{ #category : #accessing }
OPUmlAssociationBuilder >> startSymbol [
	^ super startSymbol
		==>
			[ :nodes | 
			nodes = '<'
				ifTrue: [ {DCUmlAggregationKind none.
					true} ]
				ifFalse: [ nodes ] ]
]

{ #category : #accessing }
OPUmlAssociationBuilder >> typeSymbol [
	^ super typeSymbol
		==>
			[ :symbol | 
			Array
				with:
					({($- -> DCUmlAggregationKind none).
					('<>' -> DCUmlAggregationKind shared).
					('<*>' -> DCUmlAggregationKind composite)} asDictionary at: symbol)
				with: false ]
]
