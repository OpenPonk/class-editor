Class {
	#name : #UPGBaseGenerator,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #'generator - method' }
UPGBaseGenerator >> addEagerValueFor: anEntity in: aClass [
	| expression |
	expression := self defaultValueExpressionFor: anEntity.
	expression ifNil: [ ^ self ].
	self
		addToInitialize: ('{1} := {2}' format: (Array with: anEntity name with: expression))
		in: aClass
]

{ #category : #'generator - method' }
UPGBaseGenerator >> addLazyValueFor: anAttribute in: aClass [
	| expression |
	expression := self defaultValueExpressionFor: anAttribute.
	expression ifNil: [ ^ self ].
	aClass
		compile:
			('{name}
	{pragma}
	^ {name} ifNil: [ {name} := {value} ]'
				format:
					(Dictionary
						with: #name -> anAttribute name
						with: #pragma -> (self getterPragmaFor: anAttribute)
						with: #value -> expression))
		classified: 'accessing'
]

{ #category : #'generator - method' }
UPGBaseGenerator >> addToInitialize: aCodeString in: aClass [
	| node |
	self ensureHasInitialize: aClass.
	node := RBParser parseExpression: aCodeString.
	((aClass >> #initialize) ast body statements includes: node)
		ifTrue: [ ^ self ].
	aClass compile: (aClass >> #initialize) sourceCode , '.' , aCodeString.
	(aClass >> #initialize) reformat
]

{ #category : #utilities }
UPGBaseGenerator >> classFor: aName [
	^ aName asSymbol asClass
]

{ #category : #helpers }
UPGBaseGenerator >> classNameFor: aString [
	self context shouldAlwaysUsePrefix not
		and: [ ((Smalltalk hasClassNamed: aString)
				and: [ (aString asClass package name = self context package) not ])
				ifTrue: [ ^ aString ] ].
	^ self context prefix , aString
]

{ #category : #accessing }
UPGBaseGenerator >> context [
	^ context ifNil: [ context := UPGGeneratorContext new ]
]

{ #category : #accessing }
UPGBaseGenerator >> context: aGeneratorContext [
	context := aGeneratorContext
]

{ #category : #utilities }
UPGBaseGenerator >> defaultValueExpressionFor: anEntity [
	(anEntity isAttribute and: [ anEntity defaultValue isNotNil ])
		ifTrue: [ ^ anEntity defaultValue valueExpression ].
	anEntity multiplicity upper > 1
		ifTrue: [ ^ 'OrderedCollection new' ].
	^ nil
]

{ #category : #'generator - method' }
UPGBaseGenerator >> ensureHasInitialize: aClass [
	(aClass includesSelector: #initialize)
		ifFalse: [ aClass
				compile:
					'initialize
	super initialize'
				classified: 'initialization' ]
]

{ #category : #'generator - attribute' }
UPGBaseGenerator >> ensureInstVariable: aName in: aClass [
	((aClass withAllSuperclasses flatCollect: #instVarNames) includes: aName)
		ifTrue: [ ^ false ].
	aClass addInstVarNamed: aName.
	^ true
]

{ #category : #utilities }
UPGBaseGenerator >> paramNameForType: aType [
	^ (aType name first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ]) , aType name
]
