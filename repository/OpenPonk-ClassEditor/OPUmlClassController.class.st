"
I am the controller for UML Classes. I manage canvas rendering, handle association and generalization creation adornments, and coordinate with ViewModels for property updates.
"
Class {
	#name : 'OPUmlClassController',
	#superclass : 'OPUmlClassifierController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlClassController class >> diagramElementClass [

	^ OPUmlClassShape
]

{ #category : 'accessing' }
OPUmlClassController class >> viewModelClass [
	^ OPUmlClassViewModel
]

{ #category : 'connecting' }
OPUmlClassController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPUmlGeneralizationController)
		| (super canBeSourceFor: aController)
		| (aController isKindOf: OPUmlExtensionController)
]

{ #category : 'connecting' }
OPUmlClassController >> canBeTargetFor: aController [

	^ (aController isKindOf: OPUmlAttributeController) or: [
		  (aController isKindOf: OPUmlOperationController) or: [
			  (aController isKindOf: OPUmlAssociationController) or: [
				  (aController isKindOf: OPUmlExtensionController) or: [
					  (aController isKindOf: OPUmlGeneralizationController) and: [
						  aController source ~= self ] ] ] ] ]
]

{ #category : 'figures' }
OPUmlClassController >> createAdornmentsBy: builder [

	self
		createAttributeAdornmentBy: builder;
		createAssociationAdornmentBy: builder;
		createGeneralizationAdornmentBy: builder
]

{ #category : 'figures' }
OPUmlClassController >> createAssociationAdornmentBy: builder [

	builder addIconForm: OPUmlIcons directedAssociationIcon action: [
		| tool |
		tool := OPConnectionCreationTool new
			        palette: self diagramController editor palette;
			        factory: [ OPUmlAssociationController new ].
		self diagramController editor palette selectTool: tool.
		tool selectedControllers: { self } ]
]

{ #category : 'figures' }
OPUmlClassController >> createAttributeAdornmentBy: builder [

	builder addIconForm: OPUmlIcons attributeIcon action: [
		| tool |
		tool := OPCreationTool new
			        palette: self diagramController editor palette;
			        factory: [ OPUmlAttributeController new ].
		self diagramController editor palette selectTool: tool.
		tool whenCreated: [ :ctrl |
			OPRenameElementCommand executeOn: ctrl.
			ctrl modelChanged ].
		tool selectedControllers: { self } ]
]

{ #category : 'figures' }
OPUmlClassController >> createGeneralizationAdornmentBy: builder [

	builder addIconForm: OPUmlIcons generalizationIcon action: [
		| tool |
		tool := OPConnectionCreationTool new
			        palette: self diagramController editor palette;
			        factory: [ OPUmlGeneralizationController new ].
		self diagramController editor palette selectTool: tool.
		tool selectedControllers: { self } ]
]

{ #category : 'forms' }
OPUmlClassController >> descriptionIsAbstract [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionIsAbstract' -> '`@receiver viewModel descriptionIsAbstract'.
	^ self viewModel descriptionIsAbstract
]

{ #category : 'forms' }
OPUmlClassController >> descriptionStereotype [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionStereotype' -> '`@receiver viewModel descriptionStereotype'.
	^ self viewModel descriptionStereotype
]
