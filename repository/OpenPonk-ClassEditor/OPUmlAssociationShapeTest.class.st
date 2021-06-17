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
	#category : 'OpenPonk-ClassEditor-Tests'
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
		assert: (OPUmlAssociationShape new decoratorFor: ownedComment)
		equals: OPUmlEdgeMarkers none.
	self
		assert: (OPUmlAssociationShape new decoratorFor: owningElement)
		equals: OPUmlEdgeMarkers none
]

{ #category : #tests }
OPUmlAssociationShapeTest >> testEndComposite [
	ownedComment aggregation: OPUMLAggregationKind composite.
	self
		assert: (OPUmlAssociationShape new decoratorFor: owningElement)
		equals: OPUmlEdgeMarkers filledDiamond
]

{ #category : #tests }
OPUmlAssociationShapeTest >> testEndOneNavigable [
	self
		assert: (OPUmlAssociationShape new decoratorFor: ownedComment)
		equals: OPUmlEdgeMarkers simpleArrow.
	self
		assert: (OPUmlAssociationShape new decoratorFor: owningElement)
		equals: OPUmlEdgeMarkers none
]

{ #category : #tests }
OPUmlAssociationShapeTest >> testEndShared [
	ownedComment aggregation: OPUMLAggregationKind shared.
	self
		assert: (OPUmlAssociationShape new decoratorFor: owningElement)
		equals: OPUmlEdgeMarkers emptyDiamond
]
