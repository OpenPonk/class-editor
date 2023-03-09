Class {
	#name : #OPUmlAssociationShapeTest,
	#superclass : #TestCase,
	#instVars : [
		'property',
		'element',
		'comment',
		'association',
		'ownedComment',
		'owningElement'
	],
	#category : #'OpenPonk-ClassEditor-Tests'
}

{ #category : #running }
OPUmlAssociationShapeTest >> setUp [
	super setUp.
	self setUpAssociation
]

{ #category : #running }
OPUmlAssociationShapeTest >> setUpAssociation [
	element := OPUMLClass new name: 'Element'.
	comment := OPUMLClass new name: 'Comment'.
	association := OPUMLAssociation new.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		owningClass: element;
		type: comment.
	(owningElement := OPUMLProperty new)
		name: 'owningElement';
		owningAssociation: association;
		type: element.
	association
		memberEnds:
			{ownedComment.
			owningElement}
]

{ #category : #tests }
OPUmlAssociationShapeTest >> testBothNavigable [

	owningElement
		owningAssociation: nil;
		owningClass: comment.
	self
		assert:
		(OPUmlAssociationShape new markerFor: ownedComment) shape class
		equals: OPRSMarkerBuilder arrowShape class.
	self
		assert:
		(OPUmlAssociationShape new markerFor: owningElement) shape class
		equals: OPRSMarkerBuilder arrowShape class
]

{ #category : #tests }
OPUmlAssociationShapeTest >> testEndComposite [

	ownedComment aggregation: OPUMLAggregationKind composite.
	self
		assert:
		(OPUmlAssociationShape new markerFor: owningElement) shape class
		equals: OPRSMarkerBuilder diamondShape class
]

{ #category : #tests }
OPUmlAssociationShapeTest >> testEndOneNavigable [

	self
		assert:
		(OPUmlAssociationShape new markerFor: ownedComment) shape class
		equals: OPRSMarkerBuilder arrowShape class.
	self
		assert: (OPUmlAssociationShape new markerFor: owningElement)
		equals: nil
]

{ #category : #tests }
OPUmlAssociationShapeTest >> testEndShared [

	ownedComment aggregation: OPUMLAggregationKind shared.
	self
		assert:
		(OPUmlAssociationShape new markerFor: owningElement) shape class
		equals: OPRSEmptyShapeProxy.
	self
		assert:
		(OPUmlAssociationShape new markerFor: owningElement) shape shape
			class
		equals: OPRSMarkerBuilder diamondShape class
]
