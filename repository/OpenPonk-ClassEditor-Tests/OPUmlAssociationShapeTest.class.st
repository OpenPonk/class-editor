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
	#category : 'OpenPonk-ClassEditor-Tests-DiagramElements',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'DiagramElements'
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
OPUmlAssociationShapeTest >> testAssociationEndLabelDefaultTextAllBranches [

	| endProperty endType label |
	endType := OPUMLClass new name: 'My Class'.
	endProperty := OPUMLProperty new
		               name: 'myClass';
		               type: endType;
		               yourself.
	label := OPUmlAssociationEndLabel new
		         modelElement: endProperty;
		         yourself.

	label showAssociationEndLabels: OPUmlHideEndLabelsRoassalShapeCommand styleState.
	self assert: label defaultText equals: ''.

	label showAssociationEndLabels: OPUmlShowEndLabelsRoassalShapeCommand styleState.
	self assert: label defaultText equals: 'myClass'.

	label showAssociationEndLabels: OPUmlHideSameAsClassEndLabelsRoassalShapeCommand styleState.
	self assert: label defaultText equals: ''.

	endProperty name: 'differentRole'.
	self assert: label defaultText equals: 'differentRole'.

	endType name: ''.
	self assert: label defaultText equals: 'differentRole'.

	endType name: nil.
	self assert: label defaultText equals: 'differentRole'.

	endProperty type: nil.
	self assert: label defaultText equals: 'differentRole'
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testAssociationEndLabelUpdateRenderFromStylesHandlesUnrenderedAndRendered [

	| unrenderedLabel sourceShape targetShape renderedEndLabel |
	unrenderedLabel := OPUmlAssociationEndLabel new
		                   modelElement: ownedComment;
		                   yourself.
	unrenderedLabel updateRenderFromStyles.
	self
		deny: unrenderedLabel isRendered
		description: 'Unrendered association end label must remain unrendered after updateRenderFromStyles'.

	sourceShape := OPUmlClassShape new
		               modelElement: element;
		               yourself.
	targetShape := OPUmlClassShape new
		               modelElement: comment;
		               yourself.
	sourceShape renderIn: canvas.
	targetShape renderIn: canvas.
	shape
		modelElement: model;
		source: sourceShape;
		target: targetShape;
		createOwnedElementsWithoutController;
		renderIn: canvas.
	renderedEndLabel := shape ownedElements detect: [ :each | each isKindOf: OPUmlAssociationEndLabel ].
	renderedEndLabel showAssociationEndLabels: OPUmlHideEndLabelsRoassalShapeCommand styleState.
	self assert: renderedEndLabel roassalShape text equals: ''.
	renderedEndLabel showAssociationEndLabels: OPUmlShowEndLabelsRoassalShapeCommand styleState.
	self assert: renderedEndLabel roassalShape text equals: renderedEndLabel modelElement notationStringAsRoleName
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

	| association sourceEnd targetEnd ownedElementClasses |
	association := OPUMLAssociation new name: 'donatesWith'.
	sourceEnd := OPUMLProperty new name: 'sourceEnd'.
	targetEnd := OPUMLProperty new name: 'targetEnd'.
	association memberEnds: {
			sourceEnd.
			targetEnd }.

	shape := OPUmlAssociationShape new modelElement: association.
	shape createOwnedElementsWithoutController.

	ownedElementClasses := shape ownedElements collect: #class.
	self assertCollection: ownedElementClasses includesAll: { OPUmlAssociationLabel }.
	self denyCollection: ownedElementClasses includesAny: { OPUmlAssociationPropertiesLabel }
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testAssociationStereotypesLabelDefaultText [

	| label stereotypeClass firstStereotype secondStereotype |
	label := OPUmlAssociationStereotypesLabel new
		         modelElement: model;
		         yourself.
	self assert: label defaultText equals: ''.

	stereotypeClass := Object newAnonymousSubclass.
	stereotypeClass addSlot: #umlClassName => InstanceVariableSlot.
	stereotypeClass compile: 'umlClassName ^ umlClassName' classified: 'accessing'.
	stereotypeClass compile: 'umlClassName: aSymbol umlClassName := aSymbol' classified: 'accessing'.
	firstStereotype := stereotypeClass new
		                   umlClassName: #Mediation;
		                   yourself.
	secondStereotype := stereotypeClass new
		                    umlClassName: #Derivation;
		                    yourself.
	model appliedStereotypes
		add: firstStereotype;
		add: secondStereotype.
	self assert: label defaultText equals: '«Mediation,Derivation»'
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

	self assert: (OPUmlAssociationShape new markerShapeFor: ownedComment) shape class equals: OPRSMarkerBuilder arrowShape class.
	self assert: (OPUmlAssociationShape new markerShapeFor: owningElement) identicalTo: nil
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
OPUmlAssociationShapeTest >> testExtensionShapeEndLabelsAndMarkers [

	| extension baseEnd ownedEnd extensionShape requiredLabel |
	extension := OPUMLExtension new.
	baseEnd := OPUMLProperty new name: 'base_Class'.
	ownedEnd := OPUMLExtensionEnd new
		            name: 'extension_MyStereo';
		            yourself.
	extension memberEnds: {
			baseEnd.
			ownedEnd }.
	extension ownedEnd: ownedEnd.

	extensionShape := OPUmlExtensionShape new
		                  modelElement: extension;
		                  yourself.
	extensionShape createEndLabels.
	self assertCollection: (extensionShape ownedElements collect: #class) hasSameElements: { OPUmlExtensionRequiredLabel }.
	self assert: (extensionShape markerShapeFor: baseEnd) shape class equals: OPRSMarkerBuilder triangleShape class.
	self assert: (extensionShape markerShapeFor: ownedEnd) identicalTo: nil.

	requiredLabel := extensionShape ownedElements anyOne.
	ownedEnd lowerValue: (OPUMLLiteralInteger new value: 0).
	self assert: requiredLabel defaultText equals: ''.
	ownedEnd lowerValue: (OPUMLLiteralInteger new value: 1).
	self assert: requiredLabel defaultText equals: '{required}'
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testMarkersWithNilModelAndOntoUmlDecorators [

	| stereotypeClass marker |
	self assert: OPUmlAssociationShape new headMarker identicalTo: nil.
	self assert: OPUmlAssociationShape new tailMarker identicalTo: nil.
	self assert: OPUmlEdge new headMarker identicalTo: nil.
	self assert: (OPUmlEdge new colorMarker: nil) identicalTo: nil.

	marker := OPRSMarkerBuilder arrow.
	self assert: (OPUmlEdge new colorMarker: marker) identicalTo: marker.

	stereotypeClass := Object newAnonymousSubclass.
	stereotypeClass addSlot: #umlClassName => InstanceVariableSlot.
	stereotypeClass compile: 'umlClassName ^ umlClassName' classified: 'accessing'.
	stereotypeClass compile: 'umlClassName: aSymbol umlClassName := aSymbol' classified: 'accessing'.

	#( SubQuantityOf SubCollectionOf MemberOf ) do: [ :eachStereotypeName |
			| stereotype compositeMarker sharedMarker |
			stereotype := stereotypeClass new
				              umlClassName: eachStereotypeName;
				              yourself.
			model appliedStereotypes
				removeAll;
				add: stereotype.

			ownedComment aggregation: OPUMLAggregationKind composite.
			compositeMarker := OPUmlAssociationShape new markerShapeFor: owningElement.
			self assert: compositeMarker class equals: RSMarker.
			self assert: compositeMarker shape class equals: OPRSBorderColoringComposite.

			ownedComment aggregation: OPUMLAggregationKind shared.
			sharedMarker := OPUmlAssociationShape new markerShapeFor: owningElement.
			self assert: sharedMarker class equals: OPRSEmptyMarker.
			self assert: sharedMarker shape class equals: OPRSEmptyShapeProxy ]
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

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testSwitchSourceAndTargetOnRenderedAssociationShape [

	| sourceShape targetShape sourceLabelBefore targetLabelBefore |
	sourceShape := OPUmlClassShape new
		               modelElement: element;
		               yourself.
	targetShape := OPUmlClassShape new
		               modelElement: comment;
		               yourself.
	sourceShape renderIn: canvas.
	targetShape renderIn: canvas.
	shape
		modelElement: model;
		source: sourceShape;
		target: targetShape;
		createOwnedElementsWithoutController;
		renderIn: canvas.
	sourceLabelBefore := shape ownedElements detect: [ :each |
		                     (each isKindOf: OPUmlAssociationEndLabel) and: [ each modelElement = ownedComment ] ].
	targetLabelBefore := shape ownedElements detect: [ :each |
		                     (each isKindOf: OPUmlAssociationEndLabel) and: [ each modelElement = owningElement ] ].

	shape switchSourceAndTarget.
	self assert: shape source identicalTo: targetShape.
	self assert: shape target identicalTo: sourceShape.
	self assert: shape roassalShape from identicalTo: targetShape roassalShape.
	self assert: shape roassalShape to identicalTo: sourceShape roassalShape.
	self assert: sourceLabelBefore modelElement identicalTo: owningElement.
	self assert: targetLabelBefore modelElement identicalTo: ownedComment
]

{ #category : 'tests' }
OPUmlAssociationShapeTest >> testSwitchSourceAndTargetOnUnrenderedAssociationAndPlainEdge [

	| sourceShape targetShape plainEdge generalization sourceLabelBefore targetLabelBefore |
	sourceShape := OPUmlClassShape new
		               modelElement: element;
		               yourself.
	targetShape := OPUmlClassShape new
		               modelElement: comment;
		               yourself.
	shape
		modelElement: model;
		source: sourceShape;
		target: targetShape;
		createOwnedElementsWithoutController.
	sourceLabelBefore := shape ownedElements detect: [ :each |
		                     (each isKindOf: OPUmlAssociationEndLabel) and: [ each modelElement = ownedComment ] ].
	targetLabelBefore := shape ownedElements detect: [ :each |
		                     (each isKindOf: OPUmlAssociationEndLabel) and: [ each modelElement = owningElement ] ].
	shape switchSourceAndTarget.
	self assert: shape source identicalTo: targetShape.
	self assert: shape target identicalTo: sourceShape.
	self assert: sourceLabelBefore modelElement identicalTo: owningElement.
	self assert: targetLabelBefore modelElement identicalTo: ownedComment.

	generalization := OPUMLGeneralization new
		                  specific: element;
		                  general: comment;
		                  yourself.
	plainEdge := OPUmlEdge new
		             modelElement: generalization;
		             source: sourceShape;
		             target: targetShape;
		             yourself.
	plainEdge switchSourceAndTarget.
	self assert: plainEdge source identicalTo: targetShape.
	self assert: plainEdge target identicalTo: sourceShape
]
