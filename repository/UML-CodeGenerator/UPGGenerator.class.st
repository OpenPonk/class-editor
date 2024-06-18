"
I take [FAMIX] model and generate annotated source code for it.
"
Class {
	#name : 'UPGGenerator',
	#superclass : 'UPGBaseGenerator',
	#instVars : [
		'associationsGenerator'
	],
	#category : 'UML-CodeGenerator-Generators',
	#package : 'UML-CodeGenerator',
	#tag : 'Generators'
}

{ #category : 'accessing' }
UPGGenerator >> associationsGenerator [
	^ associationsGenerator
		ifNil: [ (associationsGenerator := self associationsGeneratorFor: self context accessorsStyle)
				context: self context ]
]

{ #category : 'accessing' }
UPGGenerator >> associationsGeneratorFor: aStyle [
	aStyle = #simple
		ifTrue: [ ^ UPGSimpleAccessorsGenerator new ].
	aStyle = #direct
		ifTrue: [ ^ UPGDirectAssociationGenerator new ].
	aStyle = #fame
		ifTrue: [ ^ self notYetImplemented ].
	self error: 'Unrecognized style ' , aStyle
]

{ #category : 'generator - accessors' }
UPGGenerator >> createAccessorsFor: anAttribute in: aClass [
	| parameterName prefix isCollection |
	context shouldAddAccessors
		ifFalse: [ ^ self ].
	isCollection := anAttribute multiplicity upper > 1.
	parameterName := isCollection
		ifTrue: [ 'Collection' ]
		ifFalse: [ self typeNameFor: anAttribute ].
	prefix := parameterName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	self createGetter: anAttribute name pragma: (self getterPragmaFor: anAttribute) in: aClass.
	self createSetter: anAttribute name parameter: parameterName in: aClass.
	isCollection
		ifTrue: [ self createCollectionAccessorsFor: anAttribute in: aClass ]
]

{ #category : 'generator - association' }
UPGGenerator >> createAssociationFor: anAssociation [
	self associationsGenerator createAssociationFor: anAssociation
]

{ #category : 'generator - attribute' }
UPGGenerator >> createAttributeFor: anAttribute in: aClass [
	| cls |
	cls := aClass.
	anAttribute isStatic
		ifTrue: [ cls := cls class ].
	(self ensureInstVariable: anAttribute name in: cls) & self context shouldAddAccessors
		ifTrue: [ self createAccessorsFor: anAttribute in: cls ].
	self context shouldUseEagerInitialization
		ifTrue: [ self addEagerValueFor: anAttribute in: cls ].
	self context shouldUseLazyInitialization
		ifTrue: [ self addLazyValueFor: anAttribute in: cls ]
]

{ #category : 'generator - class' }
UPGGenerator >> createClassFor: aClass [
	| parentName |
	(self isForeignClass: aClass)
		ifTrue: [ ^ aClass smalltalkClass ].
	parentName := aClass superInheritances
		ifEmpty: [ 'Object' ]
		ifNotEmpty: [ :supers | supers first superclass name ].
	aClass stereotypes ifNotEmpty: [ :s | parentName := s first name ].
	^ parentName asClass
		subclass: aClass name
		instanceVariableNames: ''
		classVariableNames: ''
		category: self context package
]

{ #category : 'generator - class' }
UPGGenerator >> createClassesFor: aCollection [
	"Super must be created before subclasses."

	^ (aCollection asSortedCollection: [ :a :b | a superclassHierarchy includes: b ]) reversed
		collect: [ :each | self createFullClassFor: each ]
]

{ #category : 'generator - accessors' }
UPGGenerator >> createCollectionAccessorsFor: aFamixEntity in: aClass [
	| name typeName prefix |
	name := aFamixEntity name asEnglishSingular.
	typeName := self typeNameFor: aFamixEntity.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	aClass
		compile:
			('add{1}: {2}
	{3} add: {2}' format: (Array with: name capitalized with: prefix , typeName with: aFamixEntity name))
		classified: 'adding/removing'.
	aClass
		compile:
			('remove{1}: {2}
	{3} remove: {2}' format: (Array with: name capitalized with: prefix , typeName with: aFamixEntity name))
		classified: 'adding/removing'
]

{ #category : 'generator - class' }
UPGGenerator >> createFullClassFor: aFamixClass [
	| cls |
	cls := self createClassFor: aFamixClass.
	aFamixClass attributes do: [ :each | self createAttributeFor: each in: cls ].
	aFamixClass methods do: [ :each | self createMethodFor: each in: cls ].
	^ cls
]

{ #category : 'generator - accessors' }
UPGGenerator >> createGetter: aName pragma: aPragma in: aClass [
	aClass
		compile:
			('{1}
	{2}
	^ {1}' format: (Array with: aName with: aPragma with: aName))
		classified: 'accessing'
]

{ #category : 'generator - method' }
UPGGenerator >> createMethodFor: aFamixMethod in: aClass [
	| name selector parameters|
	self context shouldOverrideMethods not & (aClass selectors includes: aFamixMethod name)
		ifTrue: [ ^ self ].
	parameters := aFamixMethod parameters reject: #isReturn.
	name := $: split: aFamixMethod name.
	selector := String new writeStream.
	parameters size = 0
		ifTrue: [ selector nextPutAll: aFamixMethod name ].
	parameters
		withIndexDo:
			[ :each :i | 
			selector
				nextPutAll: (name at: i);
				nextPut: $:;
				nextPutAll: each name;
				nextPutAll: ' ' ].
	aClass
		compile:
			('{1}
	{2}
	"not yet implemented"'
				format: (Array with: selector contents with: (self methodPragmaFor: aFamixMethod))).
	(aClass >> aFamixMethod name asSymbol) reformat
]

{ #category : 'generator - accessors' }
UPGGenerator >> createSetter: aName parameter: aParameterName in: aClass [
	aClass
		compile:
			('{1}: {2}
	{1} := {2}'
				format:
					{aName.
					((aParameterName first isVowel
						ifTrue: [ 'an' ]
						ifFalse: [ 'a' ]) , aParameterName)})
		classified: 'accessing'
]

{ #category : 'generator - model' }
UPGGenerator >> generateFromModel: aModel [
	self context shouldShowProgressBar
		ifTrue: [ ^ self generateWithProgressBar: aModel ].
	(self sortedHierarchyFor: aModel allModelClasses)
		do: [ :each | self createFullClassFor: each ].
	aModel allBinaryAssociations do: [ :each | self createAssociationFor: each ]
]

{ #category : 'generator - model' }
UPGGenerator >> generateWithProgressBar: aModel [
	'Generating...'
		displayProgressFrom: 0
		to: aModel allModelClasses size + aModel allBinaryAssociations size
		during: [ :bar | 
			(self sortedHierarchyFor: aModel allModelClasses)
				do: [ :each | 
					self logCr: each name.
					bar title: 'Generating class ' , each name.
					self createFullClassFor: each.
					bar increment ].
			aModel allBinaryAssociations
				do: [ :each | 
					bar title: 'Generating association ' , each asString.
					self createAssociationFor: each.
					bar increment ] ]
]

{ #category : 'generator - accessors' }
UPGGenerator >> getterPragmaFor: anAttribute [
	^ Pragma
		keyword: #DCType:multiplicity:
		arguments:
			{(self typeNameFor: anAttribute).
			(self multiplicityFor: anAttribute multiplicity)}
]

{ #category : 'helpers' }
UPGGenerator >> isForeignClass: aClass [
	^ (Smalltalk hasClassNamed: aClass name)
		and: [ (aClass name asClass package name = self context package) not ]
]

{ #category : 'generator - method' }
UPGGenerator >> methodPragmaFor: aFamixMethod [
	^ Pragma keyword: #DCMethod: arguments: {aFamixMethod umlSignature}
]

{ #category : 'helpers' }
UPGGenerator >> multiplicityFor: aMultiplicity [
	^ {aMultiplicity printLower asNumber}
		,
			(aMultiplicity lower = aMultiplicity upper
				ifTrue: [ {} ]
				ifFalse:
					[ {(aMultiplicity printUpper = '*'
						ifTrue: [ '*' ]
						ifFalse: [ aMultiplicity upper asNumber ])} ])
]

{ #category : 'helpers' }
UPGGenerator >> sortedHierarchyFor: classes [
	^ classes asArray
		sorted: [ :a :b | (b superclassHierarchy includes: a) | (a superclassHierarchy includes: b) not ]
]

{ #category : 'accessing' }
UPGGenerator >> typeNameFor: aFamixType [
	(aFamixType isKindOf: FAMIXAttribute)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	(aFamixType isKindOf: OPFAMIXProperty)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	^ aFamixType ifNil: [ 'Object' ] ifNotNil: [ aFamixType name ]
]
