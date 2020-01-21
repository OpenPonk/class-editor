Class {
	#name : #UCMVWPsmAssociationGenerator,
	#superclass : #UPGDirectAssociationGenerator,
	#instVars : [
		'typesLookup'
	],
	#category : 'UML-CodeGenerator-VW-Generators'
}

{ #category : #'as yet unclassified' }
UCMVWPsmAssociationGenerator >> addEagerValueFor: anEntity in: aClass [
	self addLazyValueFor: anEntity in: aClass
]

{ #category : #'as yet unclassified' }
UCMVWPsmAssociationGenerator >> addLazyValueFor: anAttribute in: aClass [
	| expression source |
	expression := self defaultValueExpressionFor: anAttribute.
	expression ifNil: [ ^ self ].
	source := OPUmlSingleOpaqueBehavior
		body:
			('{name}
	^ {name} ifNil: [ {name} := {value} ]'
				format:
					(Dictionary with: #name -> anAttribute name with: #value -> expression)).
	aClass methods
		detect: [ :each | each name = anAttribute name ]
		ifFound: [ :m | m sourceAnchor: source ]
		ifNone: [ aClass
				addMethod:
					(FAMIXMethod new
						name: anAttribute name;
						protocol: 'accessing';
						sourceAnchor: source) ]
]

{ #category : #'as yet unclassified' }
UCMVWPsmAssociationGenerator >> createAssociationFor: anAssociation [
	self
		resolveAssociationEnd: anAssociation sourceEnd
		in: (typesLookup at: anAssociation targetEnd declaredType).
	self
		resolveAssociationEnd: anAssociation targetEnd
		in: (typesLookup at: anAssociation sourceEnd declaredType)
]

{ #category : #'as yet unclassified' }
UCMVWPsmAssociationGenerator >> createCollectionAccessorsFor: anEnd in: aClass [
	| adder remover |
	adder := self adder: anEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: (adder lines first splitOn: ':') first , ':';
				protocol: 'adding/removing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: adder)).
	remover := self remover: anEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: (remover lines first splitOn: ':') first , ':';
				protocol: 'adding/removing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: remover))
]

{ #category : #'as yet unclassified' }
UCMVWPsmAssociationGenerator >> createGetterFor: anAssociationEnd in: aClass [
	| source |
	source := self getter: anAssociationEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: source lines first;
				protocol: 'accessing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: source))
]

{ #category : #'as yet unclassified' }
UCMVWPsmAssociationGenerator >> createSetterFor: anAssociationEnd in: aClass [
	| source |
	source := self setter: anAssociationEnd.
	aClass
		addMethod:
			(FAMIXMethod new
				name: (source lines first splitOn: ':') first , ':';
				protocol: 'accessing';
				sourceAnchor: (OPUmlSingleOpaqueBehavior body: source))
]

{ #category : #'as yet unclassified' }
UCMVWPsmAssociationGenerator >> ensureInstVariable: aName in: aClass [
	(aClass withSuperclassHierarchy
		anySatisfy: [ :each | each attributes anySatisfy: [ :attr | attr name = aName ] ])
		ifFalse: [ aClass addAttribute: (FAMIXAttribute named: aName) ]
]

{ #category : #accessing }
UCMVWPsmAssociationGenerator >> typesLookup: anObject [
	typesLookup := anObject
]
