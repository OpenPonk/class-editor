"
I am a controller for an Enumeration
"
Class {
	#name : 'OPUmlEnumerationController',
	#superclass : 'OPUmlClassifierController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'adding' }
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

{ #category : 'construction' }
OPUmlEnumerationController >> diagramElementClass [

	^ OPUmlEnumerationShape
]

{ #category : 'figures' }
OPUmlEnumerationController >> elementsToShowInside [
	^ self model ownedLiterals asSet
]

{ #category : 'accessing' }
OPUmlEnumerationController >> modelClass [
	^ OPUMLEnumeration
]

{ #category : 'accessing' }
OPUmlEnumerationController >> modelClassName [

	^ 'Enumeration'
]
