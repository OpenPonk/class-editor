"
I compare two models and decide if they are equal.
"
Class {
	#name : #OPUmlModelComparator,
	#superclass : #Object,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #comparing }
OPUmlModelComparator >> model: a equals: b [
	a class = b class
		ifFalse: [ ^ false ].
	a class = FAMIXMethod
		ifTrue: [ ^ self operation: a equals: b ].
	a class = FAMIXParameter
		ifTrue: [ ^ self parameter: a equals: b ].
	a class = OPFAMIXMultiplicity
		ifTrue: [ ^ self multiplicity: a equals: b ].
	^ self notYetImplemented
]

{ #category : #comparing }
OPUmlModelComparator >> multiplicity: a equals: b [
	^ a lower = b lower & (a upper = b upper)
]

{ #category : #comparing }
OPUmlModelComparator >> name: a equals: b [
	^ a = b
]

{ #category : #comparing }
OPUmlModelComparator >> operation: a equals: b [
	(self name: a name equals: b name)
		ifFalse: [ ^ false ].
	a parameters size = b parameters size
		ifFalse: [ ^ false ].
	(a declaredType = nil & (b declaredType = nil)
		or:
			[ 
			(self name: a declaredType name equals: b declaredType)
				and:
					[ 
					self
						multiplicity: a declaredType multiplicity
						equals: b declaredType multiplicity ] ])
		ifFalse: [ ^ false ].

	a parameters
		withIndexDo:
			[ :each :i | 
			(self parameter: each equals: (b parameters at: i))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #comparing }
OPUmlModelComparator >> parameter: a equals: b [
	(self name: a name equals: b name)
		ifFalse: [ ^ false ].
"	a defaultValue = b defaultValue
		ifFalse: [ ^ false ]."
	(self name: a declaredType name equals: b declaredType name)
		ifFalse: [ ^ false ].
	(self multiplicity: a multiplicity equals: b multiplicity)
		ifFalse: [ ^ false ].
	^ true
]
