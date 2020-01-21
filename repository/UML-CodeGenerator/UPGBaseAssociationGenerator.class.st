Class {
	#name : #UPGBaseAssociationGenerator,
	#superclass : #UPGBaseGenerator,
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #templates }
UPGBaseAssociationGenerator >> addManyToMany: anEnd [
	^ self subclassResponsibility
]

{ #category : #templates }
UPGBaseAssociationGenerator >> addNoneToMany: anEnd [
	^ self subclassResponsibility
]

{ #category : #templates }
UPGBaseAssociationGenerator >> addOneToMany: anEnd [
	^ self subclassResponsibility
]

{ #category : #'generator - accessors' }
UPGBaseAssociationGenerator >> createAccessorsFor: anEnd in: aClass [
	self createGetterFor: anEnd in: aClass.
	self createSetterFor: anEnd in: aClass.
	anEnd multiplicity upper > 1
		ifTrue: [ self createCollectionAccessorsFor: anEnd in: aClass ]
]

{ #category : #'generator - association' }
UPGBaseAssociationGenerator >> createAssociationFor: anAssociation [
	self
		resolveAssociationEnd: anAssociation sourceEnd
		in: (self classFor: anAssociation targetEnd declaredType name).
	self
		resolveAssociationEnd: anAssociation targetEnd
		in: (self classFor: anAssociation sourceEnd declaredType name)
]

{ #category : #'generator - accessors' }
UPGBaseAssociationGenerator >> createCollectionAccessorsFor: anEnd in: aClass [
	aClass compile: (self adder: anEnd) classified: 'adding/removing'.
	aClass compile: (self remover: anEnd) classified: 'adding/removing'
]

{ #category : #'generator - accessors' }
UPGBaseAssociationGenerator >> createGetterFor: anAssociationEnd in: aClass [
	aClass compile: (self getter: anAssociationEnd) classified: 'accessing'
]

{ #category : #'generator - accessors' }
UPGBaseAssociationGenerator >> createSetterFor: anAssociationEnd in: aClass [
	aClass compile: (self setter: anAssociationEnd) classified: 'accessing'
]

{ #category : #utilities }
UPGBaseAssociationGenerator >> dslFor: anAssociation [
	^ (OPUmlDslExporter export: anAssociation) allButLast
]

{ #category : #templates }
UPGBaseAssociationGenerator >> manyToOne: anEnd [
	^ self subclassResponsibility
]

{ #category : #templates }
UPGBaseAssociationGenerator >> oneToOne: anEnd [
	^ self subclassResponsibility
]

{ #category : #utilities }
UPGBaseAssociationGenerator >> paramNameForEnd: anEnd [
	anEnd multiplicity upper > 1
		ifTrue: [ ^ 'aCollection' ].
	^ self paramNameForType: anEnd declaredType
]

{ #category : #'generator - association' }
UPGBaseAssociationGenerator >> resolveAssociationEnd: anAssociationEnd in: aClass [
	anAssociationEnd isNavigable
		ifFalse: [ ^ self ].
	(anAssociationEnd name isNil or: [ anAssociationEnd name isEmpty ])
		ifTrue: [ self flag: 'Better error handling'.
			self logCr: 'Association end doesn''t have a name'.
			^ self ].
	self ensureInstVariable: anAssociationEnd name in: aClass.
	self createAccessorsFor: anAssociationEnd in: aClass.
	self addEagerValueFor: anAssociationEnd in: aClass
]

{ #category : #utilities }
UPGBaseAssociationGenerator >> typeNameForEnd: anEnd [
	^ self paramNameForType: anEnd declaredType
]
