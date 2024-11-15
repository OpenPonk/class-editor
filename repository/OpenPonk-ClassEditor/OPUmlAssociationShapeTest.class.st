Class {
	#name : 'OPUmlAssociationShapeTest',
	#superclass : 'OPAbstractUmlEdgeTest',
	#instVars : [
		'element',
		'comment',
		'ownedComment',
		'owningElement'
	],
	#category : 'OpenPonk-ClassEditor-Tests - Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Shapes'
}

{ #category : 'instance creation' }
OPUmlAssociationShapeTest >> modelClass [

	^ OPUMLAssociation
]

{ #category : 'running' }
OPUmlAssociationShapeTest >> newModelInstance [

	| association |
	element := OPUMLClass new name: 'Element'.
	comment := OPUMLClass new name: 'Comment'.
	association := self modelClass new.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		owningClass: element;
		type: comment.
	(owningElement := OPUMLProperty new)
		name: 'owningElement';
		owningAssociation: association;
		type: element.
	association memberEnds: {
			ownedComment.
			owningElement }.
	^ association
]

{ #category : 'hooks' }
OPUmlAssociationShapeTest >> shapeClass [
	^ OPUmlAssociationShape
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testBothNavigable [

	owningElement
		owningAssociation: nil;
		owningClass: comment.
	self
		assert:
		(OPUmlAssociationShape new markerShapeFor: ownedComment) shape class
		equals: OPRSMarkerBuilder arrowShape class.
	self
		assert:
		(OPUmlAssociationShape new markerShapeFor: owningElement) shape class
		equals: OPRSMarkerBuilder arrowShape class
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testEndComposite [

	ownedComment aggregation: OPUMLAggregationKind composite.
	self
		assert:
		(OPUmlAssociationShape new markerShapeFor: owningElement) shape class
		equals: OPRSMarkerBuilder diamondShape class
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testEndOneNavigable [

	self
		assert:
		(OPUmlAssociationShape new markerShapeFor: ownedComment) shape class
		equals: OPRSMarkerBuilder arrowShape class.
	self
		assert: (OPUmlAssociationShape new markerShapeFor: owningElement)
		equals: nil
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testEndShared [

	ownedComment aggregation: OPUMLAggregationKind shared.
	self
		assert:
		(OPUmlAssociationShape new markerShapeFor: owningElement) shape class
		equals: OPRSEmptyShapeProxy.
	self
		assert:
		(OPUmlAssociationShape new markerShapeFor: owningElement) shape shape
			class
		equals: OPRSMarkerBuilder diamondShape class
]
