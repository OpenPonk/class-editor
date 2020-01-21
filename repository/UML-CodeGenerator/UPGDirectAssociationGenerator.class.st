"
Subgenerator for associations.
The code I generate will maintain bi-directional associations (when one side is updated, so is the other).
"
Class {
	#name : #UPGDirectAssociationGenerator,
	#superclass : #UPGBaseAssociationGenerator,
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #templates }
UPGDirectAssociationGenerator >> addManyToMany [
	^ 'add{nameSg}: {param}
	({name} includes: {param}) ifTrue: [ ^ self ].
	{name} add: {param}.
	{param} add{otherNameSg}: self'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> addManyToMany: anEnd [
	^ self addManyToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name
				with: #otherNameSg -> anEnd opposite name asEnglishSingular capitalized)
]

{ #category : #templates }
UPGDirectAssociationGenerator >> addNoneToMany [
	^ 'add{nameSg}: {param}
	({name} includes: {param}) ifTrue: [ ^ self ].
	{name} add: {param}'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> addNoneToMany: anEnd [
	^ self addNoneToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd))
]

{ #category : #templates }
UPGDirectAssociationGenerator >> addOneToMany [
	^ 'add{nameSg}: {param}
	({name} includes: {param}) ifTrue: [ ^ self ].
	{name} add: {param}.
	{param} {otherName}: self'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> addOneToMany: anEnd [
	^ self addOneToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name)
]

{ #category : #templates }
UPGDirectAssociationGenerator >> adder: anEnd [
	self assert: anEnd multiplicity upper > 1.
	anEnd opposite isNavigable
		ifFalse: [ ^ self addNoneToMany: anEnd ].
	^ anEnd opposite multiplicity upper = 1
		ifTrue: [ self addOneToMany: anEnd ]
		ifFalse: [ self addManyToMany: anEnd ]
]

{ #category : #templates }
UPGDirectAssociationGenerator >> getter [
	^ '{name}
	"<DCAssociation: ''{dsl}''>"
	^ {name}'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> getter: anEnd [
	^ self getter
		format: (Dictionary with: #name -> anEnd name with: #dsl -> (self dslFor: anEnd association))
]

{ #category : #templates }
UPGDirectAssociationGenerator >> manySetter [
	^ '{name}: {param}
	[ {name} isNotEmpty ] whileTrue: [ self remove{nameSg}: {name} anyOne ].
	{param} do: [ :each | self add{nameSg}: each ]'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> manySetter: anEnd [
	^ self manySetter
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self paramNameForEnd: anEnd))
]

{ #category : #templates }
UPGDirectAssociationGenerator >> manyToOne [
	^ '{name}: {param}
	|oldRef|
	{name} = {param} ifTrue: [ ^ self ].
	oldRef := {name}.
	{name} := {param}.
	"oldRef ifNotNil: [ oldRef remove{otherNameSgCapitalized}: self ]."
	oldRef ifNotNil: [ oldRef forgetAttribute: #{otherNameSg} ].
	{name} ifNotNil: [ {name} add{otherNameSgCapitalized}: self ]'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> manyToOne: anEnd [
	^ self manyToOne
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #otherNameSgCapitalized -> anEnd opposite name asEnglishSingular capitalized
				with: #otherNameSg -> anEnd opposite name asEnglishSingular
				with: #param -> (self paramNameForEnd: anEnd))
]

{ #category : #templates }
UPGDirectAssociationGenerator >> oneToOne [
	^ '{name}: {param}
	|oldRef|
	{name} = {param} ifTrue: [ ^ self ].
	oldRef := {name}.
	{name} := {param}.
	"oldRef ifNotNil: [ oldRef {otherName}: nil ]."
	oldRef ifNotNil: [ oldRef forgetAttribute: #{otherName} ].
	{name} ifNotNil: [ {name} {otherName}: self ]'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> oneToOne: anEnd [
	^ self oneToOne
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #param -> (self paramNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name)
]

{ #category : #templates }
UPGDirectAssociationGenerator >> removeManyToMany [
	^ 'remove{nameSg}: {param}
	({name} includes: {param}) ifFalse: [ ^ self ].
	{name} remove: {param}.
	{param} remove{otherNameSg}: self'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> removeManyToMany: anEnd [
	^ self removeManyToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name
				with: #otherNameSg -> anEnd opposite name asEnglishSingular capitalized)
]

{ #category : #templates }
UPGDirectAssociationGenerator >> removeNoneToMany [
	^ 'remove{nameSg}: {param}
	({name} includes: {param}) ifFalse: [ ^ self ].
	{name} remove: {param}'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> removeNoneToMany: anEnd [
	^ self removeNoneToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd))
]

{ #category : #templates }
UPGDirectAssociationGenerator >> removeOneToMany [
	^ 'remove{nameSg}: {param}
	({name} includes: {param}) ifFalse: [ ^ self ].
	{name} remove: {param}.
	{param} {otherName}: nil'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> removeOneToMany: anEnd [
	^ self removeOneToMany
		format:
			(Dictionary
				with: #name -> anEnd name
				with: #nameSg -> anEnd name asEnglishSingular capitalized
				with: #param -> (self typeNameForEnd: anEnd)
				with: #otherName -> anEnd opposite name)
]

{ #category : #templates }
UPGDirectAssociationGenerator >> remover: anEnd [
	self assert: anEnd multiplicity upper > 1.
	anEnd opposite isNavigable
		ifFalse: [ ^ self removeNoneToMany: anEnd ].
	^ anEnd opposite multiplicity upper = 1
		ifTrue: [ self removeOneToMany: anEnd ]
		ifFalse: [ self removeManyToMany: anEnd ]
]

{ #category : #templates }
UPGDirectAssociationGenerator >> setter: anEnd [
	anEnd isNavigable & anEnd opposite isNavigable not
		ifTrue: [ ^ self someToNone: anEnd ].
	anEnd multiplicity upper = 1 & (anEnd opposite multiplicity upper = 1)
		ifTrue: [ ^ self oneToOne: anEnd ].
	anEnd multiplicity upper > 1
		ifTrue: [ ^ self manySetter: anEnd ].
	anEnd multiplicity upper = 1
		ifTrue: [ ^ self manyToOne: anEnd ].
	self error: 'Unreachable'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> someToNone [
	^ '{name}: {param}
	{name} := {param}'
]

{ #category : #templates }
UPGDirectAssociationGenerator >> someToNone: anEnd [
	^ self someToNone
		format: (Dictionary with: #name -> anEnd name with: #param -> (self paramNameForEnd: anEnd))
]
