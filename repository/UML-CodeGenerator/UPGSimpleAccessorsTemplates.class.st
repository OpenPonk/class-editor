Class {
	#name : 'UPGSimpleAccessorsTemplates',
	#superclass : 'Object',
	#instVars : [
		'getter',
		'setter',
		'container'
	],
	#category : 'UML-CodeGenerator-Generators',
	#package : 'UML-CodeGenerator',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UPGSimpleAccessorsTemplates >> adder: aValue [
	container add: aValue
]

{ #category : 'as yet unclassified' }
UPGSimpleAccessorsTemplates >> getter [
	<DCAssociation: '_dsl_'>
	^ getter
]

{ #category : 'as yet unclassified' }
UPGSimpleAccessorsTemplates >> lazyGetter [
	<DCAssociation: '_dsl_'>
	^ getter ifNil: [ getter := OrderedCollection new ]
]

{ #category : 'as yet unclassified' }
UPGSimpleAccessorsTemplates >> remover: aValue [
	container remove: aValue
]

{ #category : 'as yet unclassified' }
UPGSimpleAccessorsTemplates >> setter: aValue [
	setter := aValue
]
