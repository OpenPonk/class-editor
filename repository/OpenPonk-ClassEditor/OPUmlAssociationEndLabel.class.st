Class {
	#name : 'OPUmlAssociationEndLabel',
	#superclass : 'OPUmlEdgeLabel',
	#instVars : [
		'atSource'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'ston-core' }
OPUmlAssociationEndLabel class >> stonAllInstVarNames [

	"Override to encode my instances using a custom set of instance variables or to define their order."

	^ super stonAllInstVarNames , #( #atSource )
]

{ #category : 'accessing' }
OPUmlAssociationEndLabel >> atSource [

	atSource := true
]

{ #category : 'adding' }
OPUmlAssociationEndLabel >> defaultAnchorConstraintPosition [

	^ (atSource
		   ifTrue: [ OPRSAnchorConstraintStartDistanceReference ]
		   ifFalse: [ OPRSAnchorConstraintEndDistanceReference ]) distance: 10
]

{ #category : 'adding' }
OPUmlAssociationEndLabel >> defaultMinDistance [

	^ super defaultMinDistance negated
]

{ #category : 'accessing' }
OPUmlAssociationEndLabel >> defaultText [

	| type typeName defaultText |
	self showAssociationEndLabels
	= OPUmlHideEndLabelsRoassalShapeCommand styleState ifTrue: [
		^ '' ].
	defaultText := self modelElement notationStringAsRoleName.
	self showAssociationEndLabels
	= OPUmlShowEndLabelsRoassalShapeCommand styleState ifTrue: [
		^ defaultText ].
	type := self modelElement type.
	type ifNil: [ ^ defaultText ].
	typeName := type name.
	typeName ifNil: [ ^ defaultText ].
	typeName ifEmpty: [ ^ defaultText ].
	(typeName reject: [ :each | each isSeparator ]) asLowercase
	= (defaultText reject: [ :each | each isSeparator ]) asLowercase
		ifFalse: [ ^ defaultText ].
	^ ''
]

{ #category : 'initialization' }
OPUmlAssociationEndLabel >> initialize [

	super initialize.
	atSource := false
]

{ #category : 'testing' }
OPUmlAssociationEndLabel >> supportsHidingLabelEnds [

	^ true
]

{ #category : 'initialization' }
OPUmlAssociationEndLabel >> updateRenderFromStyles [

	super updateRenderFromStyles.
	roassalShape text: self text
]
