"
Constructs and provides standardized UML data type packages containing common primitive and structured types such as Date, DateTime, Decimal, and UUID. Serves as a canonical type source for class diagrams.
"
Class {
	#name : 'OPUmlCommonTypesFactory',
	#superclass : 'Object',
	#category : 'OpenPonk-ClassEditor-Plugin',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Plugin'
}

{ #category : 'traversal' }
OPUmlCommonTypesFactory class >> collectAllElementsFrom: anElement into: anIdentitySet [
	| children |
	(anIdentitySet includes: anElement) ifTrue: [ ^ self ].
	anIdentitySet add: anElement.
	children := IdentitySet new.
	(anElement respondsTo: #ownedElements) ifTrue: [
		anElement ownedElements ifNotNil: [ :col | children addAll: col ] ].
	(anElement respondsTo: #packagedElements) ifTrue: [
		anElement packagedElements ifNotNil: [ :col | children addAll: col ] ].
	(anElement respondsTo: #ownedAttributes) ifTrue: [
		anElement ownedAttributes ifNotNil: [ :col | children addAll: col ] ].
	(anElement respondsTo: #memberEnds) ifTrue: [
		anElement memberEnds ifNotNil: [ :col | children addAll: col ] ].
	(anElement respondsTo: #ownedParameters) ifTrue: [
		anElement ownedParameters ifNotNil: [ :col | children addAll: col ] ].
	(anElement respondsTo: #ownedOperations) ifTrue: [
		anElement ownedOperations ifNotNil: [ :col | children addAll: col ] ].
	children do: [ :eachChild |
		self collectAllElementsFrom: eachChild into: anIdentitySet ]
]

{ #category : 'accessing' }
OPUmlCommonTypesFactory class >> commonTypesPackageName [
	^ 'CommonTypes'
]

{ #category : 'cleaning' }
OPUmlCommonTypesFactory class >> removeUnusedTypesFrom: aRootModel [
	| commonPkg allElements allTypedElements usedTypes canonicalNames typesToRemove |
	(aRootModel isNil or: [ (aRootModel respondsTo: #packagedElements) not ]) ifTrue: [ ^ self ].
	commonPkg := aRootModel packagedElements
		detect: [ :each | (each oclIsKindOf: #Package) and: [ each name = self commonTypesPackageName ] ]
		ifNone: [ ^ self ].

	allElements := IdentitySet new.
	self collectAllElementsFrom: aRootModel into: allElements.

	allTypedElements := allElements select: [ :each | each oclIsKindOf: #TypedElement ].
	usedTypes := (allTypedElements collect: #type thenSelect: #isNotNil) asIdentitySet.

	canonicalNames := self typeNames asSet.
	typesToRemove := commonPkg packagedElements select: [ :each |
		(each oclIsKindOf: #DataType)
			and: [ (canonicalNames includes: each name) not
			and: [ (usedTypes includes: each) not ] ] ].

	typesToRemove do: [ :eachType |
		commonPkg packagedElements remove: eachType ifAbsent: [ ] ]
]

{ #category : 'accessing' }
OPUmlCommonTypesFactory class >> typeNames [
	^ #(
		"Temporal"
		'Date' 'DateTime' 'DateAndTime' 'Time' 'Timestamp' 'Duration'
		"Numeric"
		'Decimal' 'Float' 'Double' 'Long' 'Number'
		"Character & Large Text"
		'Char' 'Text' 'Clob'
		"Binary"
		'Byte' 'ByteArray' 'Blob'
		"Web, Identifiers & Network"
		'UUID' 'URI' 'URL' 'Email'
		"Structured"
		'JSON' 'XML'
	)
]

{ #category : 'factory' }
OPUmlCommonTypesFactory >> commonTypesPackage [
	| package |
	package := OPUMLPackage new.
	package name: self class commonTypesPackageName.
	self class typeNames do: [ :typeName |
		| dataType |
		dataType := OPUMLDataType new.
		dataType name: typeName.
		package packagedElements add: dataType ].
	^ package
]
