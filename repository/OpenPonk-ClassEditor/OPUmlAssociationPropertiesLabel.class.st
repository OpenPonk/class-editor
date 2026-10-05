"
Legacy diagram element previously used for rendering association properties. Retained for backward compatibility with project files serialized in STON format. In modern diagrams, properties are formatted inline within the association label.
"
Class {
	#name : 'OPUmlAssociationPropertiesLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlAssociationPropertiesLabel >> defaultAnchorConstraintPosition [
	^ OPRSAnchorConstraintBalanceReference balance: 0.6
]

{ #category : 'accessing' }
OPUmlAssociationPropertiesLabel >> defaultText [
	^ ''
]
