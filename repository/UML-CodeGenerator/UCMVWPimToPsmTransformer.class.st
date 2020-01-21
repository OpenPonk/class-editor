"
I take PIM model and transform it into VisualWorks PSM by appling patterns specific to the CORMAS platform.
"
Class {
	#name : #UCMVWPimToPsmTransformer,
	#superclass : #Object,
	#instVars : [
		'context',
		'typesLookup',
		'associationsGenerator'
	],
	#category : 'UML-CodeGenerator-VW-Generators'
}

{ #category : #example }
UCMVWPimToPsmTransformer class >> example [
	| pim psm |
	pim := 'VegetationUnit {
	biomass : Integer = 0
}' asClassDiagram.
	pim name: 'Model'.
	pim allClasses first attributes first unit: 'kg'.
	pim allClasses first name: 'VegetationUnit (PIM)'.
	psm := UCMVWPimToPsmTransformer new generateFor: pim with: nil.
	psm allClasses first name: 'VegetationUnit (PSM)'.
	psm add: pim allClasses first.
	OPProject new
		addModel: psm;
		addModel: pim;
		open
]

{ #category : #example }
UCMVWPimToPsmTransformer class >> example1 [
	| pim psm wb e1 v1 v2 |
pim := 'VegetationUnit location --- occupant Forager[*];' asClassDiagram.
pim name: 'Model'.

psm := UCMVWPimToPsmTransformer new
	generateFor: pim with: nil.

(wb := OPWorkbench new) openProject: (OPProject new).

v1 := ((e1 := OPEditor new)
	workbench: wb;
	buildWithSpec;
	openModel: pim) canvasModel roassalView.

v2 := ((e1 := OPEditor new)
	workbench: wb;
	buildWithSpec;
	openModel: psm) canvasModel roassalView.

v1 addAll: v2 elements.
RTGridLayout new
	gapSize: 150;
	on: (v1 elements select: [ :each | each model isKindOf: OPUmlClassifierShape]).
v1
]

{ #category : #example }
UCMVWPimToPsmTransformer class >> example2 [
| pim psm wb e1 v1 v2 |
pim := '/VegetationUnit {
	biomass : Integer = 0
}' asClassDiagram.
pim name: 'Model'.
pim allClasses first attributes first unit: 'kg'.

psm := UCMVWPimToPsmTransformer new generateFor: pim with: nil.

(wb := OPWorkbench new) openProject: (OPProject new).

v1 := ((e1 := OPEditor new)
	workbench: wb;
	buildWithSpec;
	openModel: pim) canvasModel roassalView.

v2 := ((e1 := OPEditor new)
	workbench: wb;
	buildWithSpec;
	openModel: psm) canvasModel roassalView.

v1 addAll: v2 elements.
RTGridLayout on: { v1 elements first . v2 elements first }.
v1
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> accessorsFor: anAttribute [
	| accessors collection |
	self context shouldAddAccessors
		ifFalse: [ ^ #() ].
	accessors := Array
		with: (self getterFor: anAttribute)
		with: (self setterFor: anAttribute).
	collection := #().
	anAttribute isCollection
		ifTrue: [ collection := Array
				with: (self adderFor: anAttribute)
				with: (self removerFor: anAttribute) ].
	^ accessors , collection
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> adderFor: aFamixEntity [
	^ FAMIXMethod new
		name: 'add' , aFamixEntity name asEnglishSingular capitalized , ':';
		protocol: 'adding/removing';
		sourceAnchor: (self adderSourceFor: aFamixEntity)
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> adderSourceFor: aFamixEntity [
	| name typeName prefix |
	name := aFamixEntity name asEnglishSingular.
	typeName := self typeNameFor: aFamixEntity.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	^ OPUmlSingleOpaqueBehavior
		body:
			('add{1}: {2}
	{3} add: {2}'
				format:
					(Array
						with: name capitalized
						with: prefix , typeName
						with: aFamixEntity name))
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> attributeFor: anAttribute [
	^ (self entityFor: anAttribute)
		isStatic: anAttribute isStatic;
		multiplicity: anAttribute multiplicity;
		yourself
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> classFor: aClass [
	| copyClass |
	copyClass := self entityFor: aClass.
	aClass stereotypes do: [ :each | copyClass addStereotype: (self entityFor: each) ].
	aClass isAbstract
		ifTrue: [ copyClass addMethod: (self isAbstractMethodFor: aClass) ].
	aClass attributes
		do: [ :each | 
			| copy |
			copy := self attributeFor: each.
			copyClass addAttribute: copy.
			(self accessorsFor: each) do: [ :meth | copyClass addMethod: meth ].
			(self metaForAttributeFor: each) do: [ :meth | copyClass addMethod: meth ] ].
	aClass methods
		do: [ :each | 
			| copy |
			copy := self methodFor: each.
			copyClass addMethod: copy ].
	^ copyClass
]

{ #category : #accessing }
UCMVWPimToPsmTransformer >> context [
	^ context
]

{ #category : #accessing }
UCMVWPimToPsmTransformer >> context: aContext [
	context := aContext.
	associationsGenerator context: context
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> copyClassesFrom: sourceModel to: targetModel [
	sourceModel allClasses
		do: [ :cls | 
			| copy |
			copy := self classFor: cls.
			typesLookup at: cls put: copy.
			targetModel add: copy ].
	sourceModel allInheritanceDefinitions
		do: [ :each | 
			targetModel
				add:
					(FAMIXInheritance
						subclass: (typesLookup at: each subclass)
						superclass: (typesLookup at: each superclass)) ]
]

{ #category : #'public - transforming' }
UCMVWPimToPsmTransformer >> createAssociationsFor: anAssociation [
	associationsGenerator typesLookup: typesLookup.
	associationsGenerator createAssociationFor: anAssociation
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> defaultMethodFor: anAttribute [
	^ FAMIXMethod new
		name: anAttribute name , '_default';
		protocol: '- default value';
		isStatic: true;
		sourceAnchor: (self defaultMethodSourceFor: anAttribute)
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> defaultMethodSourceFor: anAttribute [
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}_default
	^ {2}'
				format:
					{anAttribute name.
					anAttribute defaultValue valueExpression})
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> eagerGetterSourceFor: anAttribute [
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}
	^ {1}'
				format:
					{anAttribute name.
					self getterPragmaFor: anAttribute})
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> entityFor: anEntity [
	^ anEntity class new
		name: anEntity name;
		yourself
]

{ #category : #'public - transforming' }
UCMVWPimToPsmTransformer >> generateFor: aPsmModel with: aContext [
	| pim |
	pim := self modelFor: aPsmModel.
	self copyClassesFrom: aPsmModel to: pim.
	aPsmModel allBinaryAssociations do: [ :each | self createAssociationsFor: each ].
	^ pim
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> getterFor: aFamixEntity [
	^ FAMIXMethod new
		name: aFamixEntity name;
		protocol: 'accessing';
		sourceAnchor: (self getterSourceFor: aFamixEntity)
]

{ #category : #'transforming - utility' }
UCMVWPimToPsmTransformer >> getterPragmaFor: anAttribute [
	^ Pragma
		keyword: #DCType:multiplicity:
		arguments:
			{(self typeNameFor: anAttribute).
			(self multiplicityFor: anAttribute multiplicity)}
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> getterSourceFor: anAttribute [
	^ (self context shouldUseLazyInitialization and: [ anAttribute defaultValue isNotNil ])
		ifTrue: [ self lazyGetterSourceFor: anAttribute ]
		ifFalse: [ self eagerGetterSourceFor: anAttribute ]
]

{ #category : #'transforming - utility' }
UCMVWPimToPsmTransformer >> indefiniteTypeNameFor: anEntity [
	| prefix base |
	base := anEntity isCollection
		ifTrue: [ 'Collection' ]
		ifFalse: [ self typeNameFor: anEntity ].
	prefix := base first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	^ prefix , base
]

{ #category : #initialization }
UCMVWPimToPsmTransformer >> initialize [
	super initialize.
	associationsGenerator := UCMVWPsmAssociationGenerator new.
	self context: UPGGeneratorContext new.
	typesLookup := Dictionary new
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> isAbstractMethodFor: aClass [
	^ FAMIXMethod new
		name: 'isAbstract';
		protocol: 'testing';
		isStatic: true;
		sourceAnchor: (self isAbstractMethodSourceFor: aClass)
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> isAbstractMethodSourceFor: aClass [
	^ OPUmlSingleOpaqueBehavior
		body:
			('isAbstract
	^ self = {1}' format: {aClass name})
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> lazyGetterSourceFor: anAttribute [
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}
	^ {1} ifNil: [ {1} := {3} ]'
				format:
					{anAttribute name.
					self getterPragmaFor: anAttribute.
					anAttribute defaultValue valueExpression})
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> metaForAttributeFor: anAttribute [
	^ Array
		streamContents: [ :stream | 
			anAttribute defaultValue ifNotNil: [ stream nextPut: (self defaultMethodFor: anAttribute) ].
			stream nextPut: (self typeMethodFor: anAttribute).
			(anAttribute unit isNotNil and: [ anAttribute unit isNotEmpty ])
				ifTrue: [ stream nextPut: (self unitMethodFor: anAttribute) ] ]
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> methodFor: aMethod [
	^ (self entityFor: aMethod)
		isStatic: aMethod isStatic;
		yourself
]

{ #category : #'transforming - associations' }
UCMVWPimToPsmTransformer >> methodsForAssociation: anAssociation [
	^ self notYetImplemented
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> modelFor: aModel [
	^ (self entityFor: aModel)
		name: aModel name , ' (PSM)';
		yourself
]

{ #category : #'transforming - utility' }
UCMVWPimToPsmTransformer >> multiplicityFor: aMultiplicity [
	^ {aMultiplicity printLower asNumber}
		,
			(aMultiplicity lower = aMultiplicity upper
				ifTrue: [ {} ]
				ifFalse:
					[ {(aMultiplicity printUpper = '*'
						ifTrue: [ '*' ]
						ifFalse: [ aMultiplicity upper asNumber ])} ])
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> removerFor: aFamixEntity [
	^ FAMIXMethod new
		name: 'remove' , aFamixEntity name asEnglishSingular capitalized , ':';
		protocol: 'adding/removing';
		sourceAnchor: (self removerSourceFor: aFamixEntity)
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> removerSourceFor: aFamixEntity [
	| name typeName prefix |
	name := aFamixEntity name asEnglishSingular.
	typeName := self typeNameFor: aFamixEntity.
	prefix := typeName first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	^ OPUmlSingleOpaqueBehavior
		body:
			('remove{1}: {2}
	{3} remove: {2}'
				format:
					(Array
						with: name capitalized
						with: prefix , typeName
						with: aFamixEntity name))
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> setterFor: aFamixEntity [
	^ FAMIXMethod new
		name: aFamixEntity name, ':';
		protocol: 'accessing';
		sourceAnchor: (self setterSourceFor: aFamixEntity)
]

{ #category : #'transforming - accessors' }
UCMVWPimToPsmTransformer >> setterSourceFor: anAttribute [
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}: {2}
	{1} = {2} ifTrue: [ ^ self ]. "for optimization"
	{1} := {2}.
	self changed'
				format:
					{anAttribute name.
					self indefiniteTypeNameFor: anAttribute})
]

{ #category : #transforming }
UCMVWPimToPsmTransformer >> typeFor: aType [
	aType ifNil: [ ^ nil ].
	typesLookup at: aType ifAbsentPut: [ self classFor: aType ].
	^ typesLookup at: aType
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> typeMethodFor: anAttribute [
	^ FAMIXMethod new
		name: anAttribute name , '_type';
		protocol: '+ parameter unit';
		isStatic: true;
		sourceAnchor: (self typeMethodSourceFor: anAttribute)
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> typeMethodSourceFor: anAttribute [
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}_type
	^ {2}'
				format:
					{anAttribute name.
					anAttribute declaredType name})
]

{ #category : #'transforming - utility' }
UCMVWPimToPsmTransformer >> typeNameFor: aFamixType [
	(aFamixType isKindOf: FAMIXAttribute)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	(aFamixType isKindOf: OPFAMIXProperty)
		ifTrue: [ ^ self typeNameFor: aFamixType declaredType ].
	^ aFamixType ifNil: [ 'Object' ] ifNotNil: [ aFamixType name ]
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> unitMethodFor: anAttribute [
	^ FAMIXMethod new
		name: anAttribute name , '_unit';
		protocol: '+ parameter unit';
		isStatic: true;
		sourceAnchor: (self unitMethodSourceFor: anAttribute)
]

{ #category : #'transforming - meta' }
UCMVWPimToPsmTransformer >> unitMethodSourceFor: anAttribute [
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}_unit
	^ ''{2}'''
				format:
					{anAttribute name.
					anAttribute unit})
]
