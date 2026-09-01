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

{ #category : 'figures' }
OPUmlEnumerationController >> createLiteralAdornmentBy: builder [

	builder addIconForm: OPUmlIcons literalIcon action: [
		| tool |
		tool := OPCreationTool new
			        palette: self diagramController editor palette;
			        factory: [ OPUMLEnumerationLiteral new ].
		self diagramController editor palette selectTool: tool.
		tool whenCreated: [ :ctrl |
			OPRenameElementCommand executeOn: ctrl.
			ctrl modelChanged ].
		tool selectedControllers: { self } ]
]

{ #category : 'model' }
OPUmlEnumerationController >> createModel [
	^ self modelClass new
		name: 'Enumeration';
		yourself
]
