"
I take code imported to Pharo from VW and try to reengineer class model for it.
"
Class {
	#name : #DCCormasVWImporter,
	#superclass : #Object,
	#instVars : [
		'modelName',
		'shouldMergeInheritances'
	],
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> ensureDefaultValue: aValue fromMethod: aMethod [
	| attr |
	attr := aMethod parentType attributes
		detect: [ :each | each name = (aMethod name withoutSuffix: '_default') ]
		ifNone: [ | a |
			a := FAMIXAttribute new.
			a name: (aMethod name withoutSuffix: '_default').
			a isStatic: aMethod isStatic.
			aMethod mooseModel add: a.
			aMethod parentType attributes add: a.
			a ].
	attr declaredType: (FAMIXClass named: (self genericTypeFor: aValue)).
	attr
		defaultValue: (OPFAMIXValueSpecification from: (self stringSpecificationFor: aValue))
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> extractDefaultValue: aClass [
	aClass methods
		select: [ :each | each name endsWith: '_default' ]
		thenDo: [ :each | 
			| ast |
			ast := each sourceAnchor pharoEntity ast.
			ast lastIsReturn
				ifTrue: [ ast body statements last value value
						ifNotNil: [ :value | self ensureDefaultValue: value fromMethod: each ] ] ]
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> extractDefaultValueFromAccessor: aMethod [
	| ast |
	ast := aMethod sourceAnchor pharoEntity ast.
	ast assignmentNodes
		ifNotEmptyDo: [ :nodes | self ensureDefaultValue: nodes first value value fromMethod: aMethod ]
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> genericTypeFor: aValue [
	aValue isInteger
		ifTrue: [ ^ 'Integer' ].
	aValue isFloat
		ifTrue: [ ^ 'Float' ].
	aValue isString
		ifTrue: [ ^ 'String' ].
	(aValue isMemberOf: RBMessageNode)
		ifTrue: [ ^ aValue receiver name ].
	^ aValue className
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> importFromClasses: aCollection [
	| model |
	model := DCCodeToUmlGenerator new importFromClasses: aCollection.
	model allModelClasses do: [ :each | self mergeClass: each ].
	^ model
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> importFromPackageNamed: aString [
	| model |
	model := DCCodeToUmlGenerator new importFromPackageNamed: aString.
	model allModelClasses do: [ :each | self mergeClass: each ].
	^ model
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> mergeAttribute: anAttribute in: aClass [
	aClass methods
		detect: [ :each | each name = anAttribute name & (each isStatic = anAttribute isStatic) ]
		ifFound: [ :method | self extractDefaultValueFromAccessor: method ].
	(Array with: anAttribute name with: anAttribute name , ':')
		do: [ :name | 
			aClass methods
				detect: [ :each | each name = name & (each isStatic = anAttribute isStatic) ]
				ifFound: [ :method | self removeMethod: method from: aClass ] ]
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> mergeClass: aClass [
	self extractDefaultValue: aClass.
	self removeDefaultValueMethods: aClass.
	self removeMetaMethods: aClass.
	({aClass} , aClass superclassHierarchy flatCollect: #attributes)
		do: [ :each | self mergeAttribute: each in: aClass ].
	shouldMergeInheritances = true
		ifTrue: [ self replaceSuperclassWithStereotype: aClass ]
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> mergeInheritances [
	shouldMergeInheritances := true
]

{ #category : #accessing }
DCCormasVWImporter >> modelName [
	^ modelName
]

{ #category : #accessing }
DCCormasVWImporter >> modelName: aString [
	modelName := aString
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> removeDefaultValueMethods: aClass [
	(aClass methods select: [ :each | each name endsWith: '_default' ])
		do: [ :each | self removeMethod: each from: aClass ]
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> removeMetaMethods: aClass [
	aClass methods
		detect: [ :each | each name = 'isAbstract' & each isStatic ]
		ifFound: [ :each | 
			aClass isAbstract: each sourceAnchor pharoEntity methodClass theNonMetaClass isAbstract.
			self removeMethod: each from: aClass ]
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> removeMethod: aMethod from: aClass [
	aMethod removeFromModel.
	aClass methods remove: aMethod
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> replaceSuperclassWithStereotype: aClass [
	| parent corePkg |
	corePkg := #'Cormas-Core'.
	"Do not merge classes from core"
	aClass parentPackage name = corePkg
		ifTrue: [ ^ self ].
	parent := aClass superclass.
	parent ifNil: [ ^ self ].
	"Do not merge classes within the model itself"
	parent parentPackage name = corePkg
		ifFalse: [ ^ self ].
	aClass mooseModel remove: aClass superInheritances first.
	aClass superInheritances remove: aClass superInheritances first.
	aClass addStereotype: (OPFAMIXStereotype named: parent name)
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> returnNodeFor: aMethod [
	| ast |
	ast := aMethod sourceAnchor pharoEntity ast.
	self assert: [ ast lastIsReturn ].
	^ ast body statements last value
]

{ #category : #'as yet unclassified' }
DCCormasVWImporter >> stringSpecificationFor: aValue [
	(aValue isMemberOf: RBMessageNode)
		ifTrue: [ ^ aValue receiver name , ' ' , aValue selector ].
	^ aValue asString
]
