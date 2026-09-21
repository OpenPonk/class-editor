"
I am the controller for UML Enumerations. I manage canvas interactions and provide specific adornment handles for creating new enumeration literals directly from the UI.
"
Class {
	#name : 'OPUmlEnumerationController',
	#superclass : 'OPUmlClassifierController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlEnumerationController class >> diagramElementClass [

	^ OPUmlEnumerationShape
]

{ #category : 'accessing' }
OPUmlEnumerationController class >> viewModelClass [
	^ OPUmlEnumerationViewModel
]

{ #category : 'connecting' }
OPUmlEnumerationController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPUmlEnumerationLiteralController)
		| (aController isKindOf: OPUmlAssociationController)
]

{ #category : 'figures' }
OPUmlEnumerationController >> createAdornmentsBy: builder [

	self createLiteralAdornmentBy: builder
]

{ #category : 'adornments' }
OPUmlEnumerationController >> createLiteralAdornmentBy: builder [
	builder addIconForm: OPUmlIcons literalIcon action: [
		| literalCreationTool |
		literalCreationTool := OPCreationTool new
			palette: self diagramController editor palette;
			factory: [ OPUmlEnumerationLiteralController new ].
		self diagramController editor palette selectTool: literalCreationTool.
		literalCreationTool whenCreated: [ :literalCtrl |
			literalCtrl modelChanged.
			literalCtrl diagramController ifNotNil: [ :targetDiagramCtrl |
				targetDiagramCtrl form ifNotNil: #focusFirstInput ] ].
		literalCreationTool selectedControllers: { self } ]
]

{ #category : 'model' }
OPUmlEnumerationController >> createModel [
	^ self modelClass new
		name: 'Enumeration';
		yourself
]
