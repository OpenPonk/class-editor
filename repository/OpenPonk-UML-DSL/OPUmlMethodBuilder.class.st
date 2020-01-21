"
I am a parser / builder that parses textual representation of an operation and creates a DCUmlOperation instance.

!! Examples

method() => new method
method(): RetType => return type
method(): RetType[0..1] => and multiplicity
method(param)
method(param  : SomeType)
method(param : SomeType, otherPar : OtherType[2..*])

!! Not yet supported
_method()_ => method is class-side
/method()/ => method is abstact
"
Class {
	#name : #OPUmlMethodBuilder,
	#superclass : #OPUmlOperationGrammar,
	#category : 'OpenPonk-UML-DSL-Builders'
}

{ #category : #grammar }
OPUmlMethodBuilder >> multiplicity [
	^ super multiplicity
		==>
			[ :nodes | 
			| m |
			m := OPFAMIXMultiplicity new.
			nodes
				ifNotNil: [ 
					m
						lower: nodes first;
						upper: nodes second ].
			m ]
]

{ #category : #grammar }
OPUmlMethodBuilder >> multiplicityRange [
	^ super multiplicityRange
		==>
			[ :nodes | 
			| min max |
			min := nodes first.
			max := nodes second.
			max = $*
				ifTrue: [ max := OPUnlimitedNatural max ].
			min
				ifNil: [ 
					min := max = OPUnlimitedNatural max
						ifTrue: [ 0 ]
						ifFalse: [ max ] ].
			Array with: min with: max ]
]

{ #category : #grammar }
OPUmlMethodBuilder >> operation [
	^ super operation
		==> [ :nodes | 
			| method |
			method := FAMIXMethod named: nodes third.
			method visibility: nodes second.
			method isStatic: (nodes first includes: $_).
			method isAbstract: (nodes first includes: $/).
			nodes fourth do: [ :each | method addParameter: each ].
			nodes fifth ifNotNil: [ :ret | method addParameter: ret ].
			method ]
]

{ #category : #grammar }
OPUmlMethodBuilder >> parameter [
	^ super parameter
		==> [ :nodes | 
			FAMIXParameter new
				name: nodes first;
				declaredType: (FAMIXClass named: (nodes second ifNil: [ 'Object' ]));
				multiplicity: nodes third;
				yourself ]
]

{ #category : #grammar }
OPUmlMethodBuilder >> returnValue [
	^ super returnValue
		==> [ :nodes | 
			FAMIXParameter new
				name: 'return';
				declaredType: (FAMIXClass named: (nodes first ifNil: [ 'Object' ]));
				direction: OPUmlParameterDirectionKind return;
				multiplicity: nodes second;
				yourself ]
]

{ #category : #grammar }
OPUmlMethodBuilder >> visibility [
	^ super visibility ==> [ :aSymbol | OPUmlVisibilityKind fromSymbol: aSymbol ]
]
