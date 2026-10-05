"
I am a unit test class verifying the visual rendering of UML Association shapes, particularly focusing on end decorators for aggregation, composition, and navigability.
"
Class {
	#name : 'OPUmlAssociationShapeTest',
	#superclass : 'OPAbstractUmlEdgeTest',
	#instVars : [
		'element',
		'comment',
		'ownedComment',
		'owningElement'
	],
	#category : 'OpenPonk-ClassEditor-Tests - DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - DiagramElements'
}

{ #category : 'instance creation' }
OPUmlAssociationShapeTest >> modelClass [

	^ OPUMLAssociation
]

{ #category : 'instance creation' }
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
OPUmlAssociationShapeTest >> testAssociationLabelDefaultTextFormattingCombinations [
	| association sourceEnd targetEnd labelClass label |
	association := OPUMLAssociation new.
	sourceEnd := OPUMLProperty new name: 'sourceEnd'.
	targetEnd := OPUMLProperty new name: 'targetEnd'.
	association memberEnds: { sourceEnd . targetEnd }.

	labelClass := OPUmlAssociationLabel newAnonymousSubclass.
	labelClass compile: 'properties
		^ (self modelElement name = ''withProps'')
			ifTrue: [ { ''essential'' } ]
			ifFalse: [ #() ]'
		classified: 'testing'.

	label := labelClass new modelElement: association.

	"1. No name, not derived, no properties -> empty"
	association isDerived: false; name: ''.
	self assert: label defaultText equals: ''.

	"2. Name, not derived, no properties -> name"
	association isDerived: false; name: 'donatesWith'.
	self assert: label defaultText equals: 'donatesWith'.

	"3. Name, derived, no properties -> slash prefix"
	association isDerived: true; name: 'donatesWith'.
	self assert: label defaultText equals: '/donatesWith'.

	"4. No name, not derived, with properties -> properties only"
	labelClass compile: 'properties ^ { ''essential'' }' classified: 'testing'.
	association isDerived: false; name: ''.
	self assert: label defaultText equals: '{essential}'.

	"5. Name, not derived, with properties -> name and properties"
	association isDerived: false; name: 'donatesWith'.
	self assert: label defaultText equals: 'donatesWith {essential}'.

	"6. Name, derived, with properties -> slash prefix, name, and properties"
	association isDerived: true; name: 'donatesWith'.
	self assert: label defaultText equals: '/donatesWith {essential}'.

	"7. No name, derived, with properties -> slash prefix, space, and properties"
	association isDerived: true; name: ''.
	self assert: label defaultText equals: '/ {essential}'.

	"8. No name, derived, no properties -> slash prefix only"
	labelClass compile: 'properties ^ #()' classified: 'testing'.
	association isDerived: true; name: ''.
	self assert: label defaultText equals: '/'
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testAssociationLabelDefaultTextIncludesProperties [
	| association sourceEnd targetEnd labelClass label |
	association := OPUMLAssociation new name: 'donatesWith'.
	sourceEnd := OPUMLProperty new name: 'sourceEnd'.
	targetEnd := OPUMLProperty new name: 'targetEnd'.
	association memberEnds: { sourceEnd . targetEnd }.

	labelClass := OPUmlAssociationLabel newAnonymousSubclass.
	labelClass compile: 'properties ^ { ''essential'' . ''inseparable'' }' classified: 'testing'.

	label := labelClass new modelElement: association.

	self assert: label defaultText equals: 'donatesWith {essential, inseparable}'
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testAssociationLabelIncludesPropertiesAndHasNoSeparatePropertiesLabel [

	| assoc end1 end2 |
	assoc := OPUMLAssociation new name: 'donatesWith'.
	end1 := OPUMLProperty new name: 'sourceEnd'.
	end2 := OPUMLProperty new name: 'targetEnd'.
	assoc memberEnds: {
			end1.
			end2 }.

	shape := OPUmlAssociationShape new modelElement: assoc.
	shape createOwnedElementsWithoutController.

	"1. Shape nesmí mít samostatný OPUmlAssociationPropertiesLabel"
	self deny: (shape ownedElements anySatisfy: [ :each | each isKindOf: OPUmlAssociationPropertiesLabel ])
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testAssociationLabelsHaveDistinctDefaultAnchorBalances [
	| nameLabel stereotypeLabel propertyLabel |
	nameLabel := OPUmlAssociationLabel new.
	stereotypeLabel := OPUmlAssociationStereotypesLabel new.
	propertyLabel := OPUmlAssociationPropertiesLabel new.

	self
		deny: nameLabel defaultAnchorConstraintPosition balance
		equals: propertyLabel defaultAnchorConstraintPosition balance.
	self
		deny: nameLabel defaultAnchorConstraintPosition balance
		equals: stereotypeLabel defaultAnchorConstraintPosition balance.
	self
		deny: stereotypeLabel defaultAnchorConstraintPosition balance
		equals: propertyLabel defaultAnchorConstraintPosition balance
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testAssociationShapeDoesNotCreateSeparatePropertiesLabel [

	| association sourceEnd targetEnd |
	association := OPUMLAssociation new name: 'donatesWith'.
	sourceEnd := OPUMLProperty new name: 'sourceEnd'.
	targetEnd := OPUMLProperty new name: 'targetEnd'.
	association memberEnds: {
			sourceEnd.
			targetEnd }.

	shape := OPUmlAssociationShape new modelElement: association.
	shape createOwnedElementsWithoutController.

	self denyCollection: (shape ownedElements collect: #class) includesAny: { OPUmlAssociationPropertiesLabel }
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

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testPropertiesFormatsNonBooleanValues [
	| label association metaClass metaInstance stereotypeClass stereotype attributeCustom result |
	association := OPUMLAssociation new.
	label := OPUmlAssociationLabel new modelElement: association.

	attributeCustom := OPUMLProperty new name: 'weight'.

	metaClass := Object newAnonymousSubclass.
	metaClass addSlot: #attributes => InstanceVariableSlot.
	metaClass compile: 'attributes: aCollection attributes := aCollection' classified: 'accessing'.
	metaClass compile: 'allAttributes ^ attributes' classified: 'accessing'.
	metaInstance := metaClass new attributes: { attributeCustom }.

	stereotypeClass := Object newAnonymousSubclass.
	stereotypeClass addSlot: #umlMetaClass => InstanceVariableSlot.
	stereotypeClass addSlot: #weight => InstanceVariableSlot.
	stereotypeClass compile: 'umlMetaClass: aMetaClass umlMetaClass := aMetaClass' classified: 'accessing'.
	stereotypeClass compile: 'umlMetaClass ^ umlMetaClass' classified: 'accessing'.
	stereotypeClass compile: 'weight: aValue weight := aValue' classified: 'accessing'.
	stereotypeClass compile: 'weight ^ weight' classified: 'accessing'.

	stereotype := stereotypeClass new
		umlMetaClass: metaInstance;
		weight: 42;
		yourself.

	association appliedStereotypes add: stereotype.
	result := label properties.

	self
		assertCollection: result
		hasSameElements: #( 'weight=42' )
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testPropertiesOmitsFalseBooleans [
	| label association metaClass metaInstance stereotypeClass stereotype attributeFalse attributeTrue result |
	association := OPUMLAssociation new.
	label := OPUmlAssociationLabel new modelElement: association.

	attributeFalse := OPUMLProperty new name: 'essential'.
	attributeTrue := OPUMLProperty new name: 'inseparable'.

	metaClass := Object newAnonymousSubclass.
	metaClass addSlot: #attributes => InstanceVariableSlot.
	metaClass compile: 'attributes: aCollection attributes := aCollection' classified: 'accessing'.
	metaClass compile: 'allAttributes ^ attributes' classified: 'accessing'.
	metaInstance := metaClass new attributes: { attributeFalse . attributeTrue }.

	stereotypeClass := Object newAnonymousSubclass.
	stereotypeClass addSlot: #umlMetaClass => InstanceVariableSlot.
	stereotypeClass addSlot: #essential => InstanceVariableSlot.
	stereotypeClass addSlot: #inseparable => InstanceVariableSlot.
	stereotypeClass compile: 'umlMetaClass: aMetaClass umlMetaClass := aMetaClass' classified: 'accessing'.
	stereotypeClass compile: 'umlMetaClass ^ umlMetaClass' classified: 'accessing'.
	stereotypeClass compile: 'essential: aBoolean essential := aBoolean' classified: 'accessing'.
	stereotypeClass compile: 'essential ^ essential' classified: 'accessing'.
	stereotypeClass compile: 'inseparable: aBoolean inseparable := aBoolean' classified: 'accessing'.
	stereotypeClass compile: 'inseparable ^ inseparable' classified: 'accessing'.

	stereotype := stereotypeClass new
		umlMetaClass: metaInstance;
		essential: false;
		inseparable: true;
		yourself.

	association appliedStereotypes add: stereotype.
	result := label properties.

	self
		assertCollection: result
		hasSameElements: #( 'inseparable' )
]
