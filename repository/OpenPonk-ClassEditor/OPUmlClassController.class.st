"
I am a controller for a Class(ifier)
"
Class {
	#name : 'OPUmlClassController',
	#superclass : 'OPUmlClassifierController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'adding' }
OPUmlClassController >> canBeSourceFor: aController [
	^ (aController isKindOf: OPUmlGeneralizationController)
		| (super canBeSourceFor: aController)
		| (aController isKindOf: OPUmlExtensionController)
]

{ #category : 'adding' }
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
			ctrl diagramElement modelChanged ].
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

{ #category : 'accessing' }
OPUmlClassController >> dependentElements [

	| ownGeneralizations generalizationsFromSets otherClassesGeneralizations |
	ownGeneralizations := self model generalizations.
	generalizationsFromSets := nil.
	generalizationsFromSets := self
		                           parentPackageDo: [ :parentPackage |
			                           (parentPackage packagedElements select: [
				                            :eachPackageElement |
				                            eachPackageElement oclIsKindOf:
					                            #GeneralizationSet ])
				                           flatCollectAsSet: [ :eachSet |
					                           eachSet generalizations select: [
						                           :eachGeneralization |
						                           eachGeneralization general
						                           = self model or: [
							                           eachGeneralization specific
							                           = self model ] ] ] ]
		                           ifNone: [ #(  ) ].
	otherClassesGeneralizations := self
		                               parentPackageDo: [ :parentPackage |
			                               (parentPackage packagedElements
				                                select: [ :eachPackageElement |
				                                eachPackageElement oclIsKindOf:
					                                #Class ]) flatCollectAsSet: [
				                               :eachClass |
				                               eachClass generalizations select: [
					                               :eachGeneralization |
					                               eachGeneralization general
					                               = self model or: [
						                               eachGeneralization specific
						                               = self model ] ] ] ]
		                               ifNone: [ #(  ) ].

	^ super dependentElements , ownGeneralizations
	  , generalizationsFromSets , otherClassesGeneralizations
]

{ #category : 'forms' }
OPUmlClassController >> descriptionIsAbstract [

	<magritteDescription>
	^ MABooleanDescription new
		  accessor: (self descriptionAccessor: #isAbstract);
		  label: 'Is Abstract';
		  priority: 5;
		  yourself
]

{ #category : 'forms' }
OPUmlClassController >> descriptionStereotype [

	<magritteDescription>
	^ self descriptionStereotypeContent
]

{ #category : 'figures' }
OPUmlClassController >> diagramElementClass [

	^ OPUmlClassShape
]

{ #category : 'accessing' }
OPUmlClassController >> elementsToShowInside [

	^ model ownedOperations asSet , model ownedAttributes
]

{ #category : 'accessing' }
OPUmlClassController >> modelClass [
	^ OPUMLClass
]

{ #category : 'accessing' }
OPUmlClassController >> modelClassName [

	^ 'Class'
]
