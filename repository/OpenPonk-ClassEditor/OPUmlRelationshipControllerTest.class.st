Class {
	#name : 'OPUmlRelationshipControllerTest',
	#superclass : 'OPAbstractDirectionalRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'testing' }
OPUmlRelationshipControllerTest class >> isAbstract [
	^ self = OPUmlRelationshipControllerTest
]

{ #category : 'as yet unclassified' }
OPUmlRelationshipControllerTest >> allElements [

	^ self allElementsOf: diagramController model
]

{ #category : 'as yet unclassified' }
OPUmlRelationshipControllerTest >> allElementsOf: aPackage [

	| elements |
	elements := Set withAll: aPackage packagedElements.
	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			elements addAll: (self allElementsOf: each).
			each packageImports do: [ :import |
				elements add: import importedPackage.
				elements add: import ] ].
	aPackage packagedElements
		select: [ :each |
			(each isKindOf: OPUMLClass) | (each isKindOf: OPUMLStereotype) ]
		thenDo: [ :each |
			each generalizations do: [ :gen |
				elements add: gen general.
				elements add: gen ].
			(each ownedAttributes select: [ :attr |
				 attr isKindOf: OPUMLProperty ]) do: [ :attr |
				elements add: attr.
				attr association ifNotNil: [ elements add: attr association ] ].
			(each ownedOperations select: [ :op | op isKindOf: OPUMLOperation ])
				do: [ :op | elements add: op ] ].
	aPackage packagedElements
		select: [ :each | each isKindOf: OPUMLStereotype ]
		thenDo: [ :each |
			each ownedAttributes
				select: [ :attr |
					attr association isNotNil and: [
						attr association isKindOf: OPUMLExtension ] ]
				thenDo: [ :attr | elements add: attr type ] ].
	^ elements
]

{ #category : 'initialization' }
OPUmlRelationshipControllerTest >> assignModelSource [
]

{ #category : 'initialization' }
OPUmlRelationshipControllerTest >> assignModelTarget [
]

{ #category : 'accessing' }
OPUmlRelationshipControllerTest >> diagramControllerClass [

	^ OPUmlPackageDiagramController
]

{ #category : 'accessing' }
OPUmlRelationshipControllerTest >> diagramModelClass [

	^ OPUMLPackage
]

{ #category : 'running' }
OPUmlRelationshipControllerTest >> setUpSourceModel [

	^ super setUpSourceModel
		  name: 'SourceModel';
		  yourself
]

{ #category : 'running' }
OPUmlRelationshipControllerTest >> setUpTargetModel [

	^ super setUpTargetModel
		  name: 'TargetModel';
		  yourself
]

{ #category : 'as yet unclassified' }
OPUmlRelationshipControllerTest >> sourceControllerClass [

	^ OPUmlClassController
]

{ #category : 'as yet unclassified' }
OPUmlRelationshipControllerTest >> sourceModelClass [

	^ OPUMLClass
]

{ #category : 'tests - creation' }
OPUmlRelationshipControllerTest >> testCanClassBeSource [
	self assert: (OPUmlClassController new canBeSourceFor: controller)
]

{ #category : 'tests - creation' }
OPUmlRelationshipControllerTest >> testCanClassBeTarget [
	self assert: (OPUmlClassController new canBeTargetFor: controller)
]

{ #category : 'tests - creation' }
OPUmlRelationshipControllerTest >> testClassBeSource [
	| source |
	source := OPUmlClassController new.
	source addAsSourceFor: controller.
	self assert: controller source equals: source
]
