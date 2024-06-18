"
I take a DCFAMIX model and create an equivalent DSL from it.
"
Class {
	#name : 'OPUmlDslExporter',
	#superclass : 'Object',
	#instVars : [
		'stream'
	],
	#category : 'OpenPonk-UML-DSL-Exporter',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Exporter'
}

{ #category : 'public-exporting' }
OPUmlDslExporter class >> export: aModel [
	^ self new export: aModel
]

{ #category : 'public-exporting' }
OPUmlDslExporter >> export: aModel [
	stream := String new writeStream.
	(aModel isKindOf: MooseModel)
		ifTrue: [ self visitModel: aModel ]
		ifFalse: [ aModel accept: self ].
	^ stream contents
]

{ #category : 'accessing' }
OPUmlDslExporter >> line [
	stream nextPutAll: String cr
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitAssociation: anAssociation [
	self visitType: anAssociation source withMultiplicity: anAssociation sourceEnd multiplicity separator: ''.
	stream nextPut: Character space.
	anAssociation sourceEnd name
		ifNotNil: [ :n | 
			stream
				nextPutAll: n;
				nextPut: Character space ].
	anAssociation targetEnd aggregation = OPUmlAggregationKind shared
		ifTrue: [ stream nextPutAll: '<>' ].
	anAssociation targetEnd aggregation = OPUmlAggregationKind composite
		ifTrue: [ stream nextPutAll: '<*>' ].
	anAssociation targetEnd aggregation = OPUmlAggregationKind none
		ifTrue: [ (anAssociation sourceEnd isNavigable not or: [ anAssociation targetEnd isNavigable ])
				ifTrue: [ stream nextPut: $- ]
				ifFalse: [ stream nextPut: $< ] ].
	stream nextPut: $-.
	anAssociation sourceEnd aggregation = OPUmlAggregationKind shared
		ifTrue: [ stream nextPutAll: '<>' ].
	anAssociation sourceEnd aggregation = OPUmlAggregationKind composite
		ifTrue: [ stream nextPutAll: '<*>' ].
	anAssociation sourceEnd aggregation = OPUmlAggregationKind none
		ifTrue: [ (anAssociation targetEnd isNavigable not or: [ anAssociation sourceEnd isNavigable ])
				ifTrue: [ stream nextPut: $- ]
				ifFalse: [ stream nextPut: $> ] ].
	stream nextPut: Character space.
	anAssociation targetEnd name
		ifNotNil: [ :n | 
			stream
				nextPutAll: n;
				nextPut: Character space ].
	self visitType: anAssociation target withMultiplicity: anAssociation targetEnd multiplicity separator: ''.
	anAssociation name
		ifNotEmpty: [ :n | 
			stream
				nextPutAll: ' : ';
				nextPutAll: n ].
	stream nextPut: $;
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitAttribute: anAttribute [
	anAttribute isStatic
		ifTrue: [ stream nextPut: $_ ].
	stream nextPutAll: anAttribute name.

	self visitTypeWithMultiplicity: anAttribute.
	anAttribute defaultValue
		ifNotNil:
			[ :val | 
			stream
				nextPutAll: ' = ';
				nextPutAll: val valueExpression asString ]
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitClass: aClass [
	aClass isAbstract
		ifTrue: [ stream nextPut: $/ ].
	stream nextPutAll: aClass name.
	stream nextPut: Character space.
	aClass stereotypes
		ifNotEmpty:
			[ stream nextPutAll: '<<'.
			stream nextPutAll: ((aClass stereotypes collect: #name) joinUsing: ',').
			stream nextPutAll: '>>'.
			stream nextPut: Character space ].
	aClass methods isEmpty & aClass attributes isEmpty
		ifTrue: [ stream nextPutAll: '{ }'.
			^ self ].
	stream nextPut: ${.
	self line.
	aClass attributes
		do: [ :each | 
			stream nextPut: Character tab.
			self visitAttribute: each.
			self line ].
	aClass methods
		do: [ :each | 
			stream nextPut: Character tab.
			self visitMethod: each.
			self line ].
	stream nextPut: $}
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitInheritance: anInheritance [
	stream nextPutAll: anInheritance subclass name.
	stream nextPutAll: ' >> '.
	stream nextPutAll: anInheritance superclass name.
	stream nextPut: $;
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitMethod: aMethod [
	aMethod isStatic
		ifTrue: [ stream nextPut: $_ ].
	aMethod isAbstract
		ifTrue: [ stream nextPut: $/ ].
	stream nextPutAll: aMethod name.
	stream nextPut: $(.
	(aMethod parameters reject: #isReturn)
		do: [ :each | self visitParameter: each ]
		separatedBy: [ stream nextPutAll: ', ' ].
	stream nextPut: $).
	self visitTypeWithMultiplicity: aMethod
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitModel: aModel [
	aModel allClasses
		do: [ :each | self visitClass: each ]
		separatedBy: [ self line.
			self line ].
	aModel allInheritanceDefinitions isNotEmpty
		ifTrue: [ self line.
			self line ].
	aModel allInheritanceDefinitions
		do: [ :each | self visitInheritance: each ]
		separatedBy: [ self line ].
	aModel allBinaryAssociations isNotEmpty
		ifTrue: [ self line.
			self line ].
	aModel allBinaryAssociations
		do: [ :each | self visitAssociation: each ]
		separatedBy: [ self line ]
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitParameter: aParameter [
	stream nextPutAll: aParameter name.
	self visitTypeWithMultiplicity: aParameter
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitType: aType withMultiplicity: aMultiplicity separator: aSeparator [
	"
	foo : Object[1..1] => foo
	foo : String[1..1] => foo : String
	"

	aType name = 'Object' & (aMultiplicity lower = 1) & (aMultiplicity upper = 1)
		ifTrue: [  ].
	aType name ~= 'Object' & (aMultiplicity lower = 1) & (aMultiplicity upper = 1)
		ifTrue: [ stream
				nextPutAll: aSeparator;
				nextPutAll: aType name ].
	aMultiplicity lower ~= 1 | (aMultiplicity upper ~= 1)
		ifTrue: [ stream
				nextPutAll: aSeparator;
				nextPutAll: aType name;
				nextPutAll: aMultiplicity printRange ]
]

{ #category : 'visitor' }
OPUmlDslExporter >> visitTypeWithMultiplicity: aType [
	aType declaredType ifNil: [ ^ self ].
	(aType isKindOf: FAMIXMethod)
		ifTrue: [ stream
				nextPutAll: ' : ';
				nextPutAll: aType declaredType name;
				nextPutAll: aType multiplicity asOptionalString.
			^ self ].
	self visitType: aType declaredType withMultiplicity: aType multiplicity separator: ' : '
]
