Class {
	#name : #UPGFameAccessorsTemplates,
	#superclass : #UPGSimpleAccessorsTemplates,
	#instVars : [
		'value',
		'attribute'
	],
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #'as yet unclassified' }
UPGFameAccessorsTemplates >> setterMany: aValue [
	setter value: aValue
]

{ #category : #'as yet unclassified' }
UPGFameAccessorsTemplates >> setterManyToNone: aCollection [
	attribute := aCollection
]

{ #category : #'as yet unclassified' }
UPGFameAccessorsTemplates >> setterOneToMany: aValue [
	setter := FMMultivalueLink
		on: self
		update: #opposites
		from: setter
		to: aValue
]

{ #category : #'as yet unclassified' }
UPGFameAccessorsTemplates >> setterOneToNone: aValue [
	attribute := aValue
]

{ #category : #'as yet unclassified' }
UPGFameAccessorsTemplates >> setterOneToOne: aValue [
	attribute := aValue
]
