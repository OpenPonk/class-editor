"
The primary diagram shape for a UML Class. Composes compartments for attributes and operations, managing their layout and visual dividers.
"
Class {
	#name : 'OPUmlClassShape',
	#superclass : 'OPUmlClassifierShape',
	#instVars : [
		'attributesCompartment',
		'operationsCompartment'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'ston-core' }
OPUmlClassShape class >> stonAllInstVarNames [
	^ super stonAllInstVarNames , #( #attributesCompartment #operationsCompartment )
]

{ #category : 'rendering' }
OPUmlClassShape >> addAttribute: anAttributeShape [
	attributesCompartment ifNil: [
		attributesCompartment := OPUmlListCompartment in: self.
		self sortOwnedElements ].
	anAttributeShape owningElement: attributesCompartment
]

{ #category : 'rendering' }
OPUmlClassShape >> addOperation: anOperationShape [
	operationsCompartment ifNil: [
		operationsCompartment := OPUmlFeaturesListCompartment in: self.
		self sortOwnedElements ].
	anOperationShape owningElement: operationsCompartment
]

{ #category : 'accessing' }
OPUmlClassShape >> attributesCompartment [
	^ attributesCompartment
]

{ #category : 'accessing' }
OPUmlClassShape >> operationsCompartment [
	^ operationsCompartment
]

{ #category : 'rendering' }
OPUmlClassShape >> removeAttribute: anAttributeShape [
	anAttributeShape remove.
	attributesCompartment ifNotNil: [ :compartment |
		compartment ownedElements ifEmpty: [
			attributesCompartment remove.
			attributesCompartment := nil ] ].
	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : 'rendering' }
OPUmlClassShape >> removeOperation: anOperationShape [
	anOperationShape remove.
	operationsCompartment ifNotNil: [ :compartment |
		compartment ownedElements ifEmpty: [
			operationsCompartment remove.
			operationsCompartment := nil ] ].
	self isRendered ifTrue: [ self updateRenderFromModel ]
]

{ #category : 'sorting' }
OPUmlClassShape >> sortOwnedElements [
	| properOrder |
	properOrder := (self ownedElements select: [ :each |
		                each isKindOf: OPUmlCompartmentableLabel ]) , {
		               attributesCompartment.
		               operationsCompartment.
		               commentIcon } reject: [ :eachElement | eachElement isNil ].
	self assert:
		self ownedElements asIdentitySet = properOrder asIdentitySet.
	self ownedElements: properOrder
]

{ #category : 'rendering' }
OPUmlClassShape >> stereotypesLabelClass [

	^ OPUmlAppliedStereotypesLabel
]

{ #category : 'ston-core' }
OPUmlClassShape >> stonInstVarNameFor: anInstVarName [
	anInstVarName = #attributes ifTrue: [ ^ #attributesCompartment ].
	anInstVarName = #operations ifTrue: [ ^ #operationsCompartment ].
	^ super stonInstVarNameFor: anInstVarName
]
