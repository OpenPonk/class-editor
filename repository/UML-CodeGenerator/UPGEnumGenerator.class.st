"
I wrap code generation for Enumerations.

!! Example

BormParticipantType <<enumeration>> {
	Organization
	Person
	System
}

will be generated to:

BormParticipantType {
	+Organization() : #Organization
	+Person() : #Person
	+System() : #Symbol
	_+default() : BormParticipantType
}
"
Class {
	#name : #UPGEnumGenerator,
	#superclass : #Object,
	#instVars : [
		'enumModel'
	],
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #accessing }
UPGEnumGenerator >> ensureClass: anEnum [
	| oldPkg newPkg parentName |
	newPkg := anEnum parentPackage ifNil: [ 'Unclassified' ] ifNotNil: #name.
	oldPkg := anEnum smalltalkClass ifNil: [ newPkg ] ifNotNil: [ :cls | cls package name ].
	newPkg = oldPkg
		ifFalse: [ self
				error:
					('Cannot move class {1} from package {2} to {3}.'
						format: (Array with: anEnum name with: oldPkg with: newPkg)) ].
	parentName := anEnum superInheritances
		ifEmpty: [ 'Object' ]
		ifNotEmpty: [ :supers | supers first superclass name ].
	^ Object
		subclass: anEnum name
		instanceVariableNames: ''
		classVariableNames: ''
		category: newPkg
]

{ #category : #accessing }
UPGEnumGenerator >> ensureInstanceMethodFor: aPair in: aClass [
	| method |
	method := '{1}
	"Generated method"

	^ {2}'
		format:
			{aPair key.
			aPair value}.
	((aClass includesSelector: aPair key)
		and: [ (aClass >> aPair key) sourceCode = method ])
		ifFalse: [ aClass compile: method classified: 'accessing - literals' ]
]

{ #category : #accessing }
UPGEnumGenerator >> ensureMetaMethodsIn: aClass [
	| method |
	(aClass hasInstVarNamed: #Default)
		ifFalse: [ aClass addInstVarNamed: #Default ].
	method := 'enum
	"Generated method"

	^ Default ifNil: [ Default := self new ]'.
"	1 halt."
	((aClass includesSelector: #meta) and: [ (aClass >> #meta) sourceCode = method ])
		ifFalse: [ aClass compile: method classified: 'accessing' ]
]

{ #category : #accessing }
UPGEnumGenerator >> execute [
	self executeOn: enumModel
]

{ #category : #accessing }
UPGEnumGenerator >> executeOn: anEnum [
	| literals |
	self ensureClass: anEnum.
	literals := self literalsFor: anEnum.
	self ensureMetaMethodsIn: anEnum smalltalkClass class.
	literals
		associationsDo: [ :each | 
			self ensureInstanceMethodFor: each in: anEnum smalltalkClass.
			self tryClassMethodFor: each in: anEnum smalltalkClass ].
]

{ #category : #accessing }
UPGEnumGenerator >> literalsFor: anEnum [
	"Proper enum literals are not yet supported so I am abusing attributes"

	^ (anEnum attributes collect: [ :each | each name asSymbol -> each name asSymbol printString ]) asDictionary
]

{ #category : #accessing }
UPGEnumGenerator >> model: anEnum [
	enumModel := anEnum
]

{ #category : #accessing }
UPGEnumGenerator >> tryClassMethodFor: aPair in: aClass [
	"Class side is a minefield so be extra careful."

	| method |
	(Object respondsTo: aPair key)
		ifTrue: [ ^ self ].
	method := '{1}
	"Generated method"

	^ self enum {1}' format: {aPair key}.
	((aClass class includesSelector: aPair key)
		and: [ (aClass class >> aPair key) sourceCode = method ])
		ifFalse: [ aClass class compile: method classified: 'accessing - literals' ]
]
