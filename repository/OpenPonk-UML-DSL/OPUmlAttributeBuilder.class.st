"
I am a parser / builder that parses textual representation of an attribute and creates an DCUmlAttribute instance.

!! Examples

attributeName => FAMIX Attribute named  'attributeName'
attributeName : SomeType => with declared type
attributeName : SomeType[0..1] => and declared multiplicity

!! Not yet supported
_attribute : flags_ => attribute is class-side
_attribute : flags = someValue => default value
"
Class {
	#name : #OPUmlAttributeBuilder,
	#superclass : #OPUmlPropertyGrammar,
	#category : 'OpenPonk-UML-DSL-Builders'
}

{ #category : #building }
OPUmlAttributeBuilder >> defaultValue [
	^ super defaultValue ==> [ :expression | OPFAMIXValueSpecification from: expression ]
]

{ #category : #building }
OPUmlAttributeBuilder >> multiplicity [
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

{ #category : #building }
OPUmlAttributeBuilder >> multiplicityRange [
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

{ #category : #building }
OPUmlAttributeBuilder >> property [
	^ super property
		==> [ :nodes | 
			FAMIXAttribute new
				name: nodes third;
				visibility: nodes second;
				isStatic: (nodes first includes: $_);
				defaultValue: nodes sixth;
				declaredType: (nodes fourth ifNotNil: [ FAMIXClass named: nodes fourth ]);
				multiplicity: nodes fifth ]
]

{ #category : #building }
OPUmlAttributeBuilder >> visibility [
	^ super visibility ==> [ :aSymbol | OPUmlVisibilityKind fromSymbol: aSymbol ]
]
