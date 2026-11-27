"
I am a unit test class verifying the behavior of OPUmlPackageDiagramController, explicitly testing the correct canvas rendering of UML classes and their inner attributes.
"
Class {
	#name : 'OPUmlPackageDiagramControllerTest',
	#superclass : 'OPAbstractDiagramControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests-Controllers',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlPackageDiagramControllerTest class >> diagramElementClass [

	^ OPOpenPonkDiagram
]

{ #category : 'constants' }
OPUmlPackageDiagramControllerTest >> controllerClass [
	^ OPUmlPackageDiagramController
]

{ #category : 'construction' }
OPUmlPackageDiagramControllerTest >> diagramElementClass [
	^ self class diagramElementClass
]

{ #category : 'constants' }
OPUmlPackageDiagramControllerTest >> modelClass [
	^ OPUMLPackage
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testInitializePaletteCreatesExpectedFactoriesForPackageAndProfile [

	| palette expectedClasses profileController profilePalette |
	palette := OPPalette new.
	controller initializePalette: palette.
	expectedClasses := {
		                   ('Class' -> OPUmlClassController).
		                   ('Attribute' -> OPUmlAttributeController).
		                   ('Operation' -> OPUmlOperationController).
		                   ('Association' -> OPUmlAssociationController).
		                   ('Generalization' -> OPUmlGeneralizationController).
		                   ('Enumeration' -> OPUmlEnumerationController).
		                   ('Enumeration Literal' -> OPUmlEnumerationLiteralController).
		                   ('Package Import' -> OPUmlPackageImportController).
		                   ('Package' -> OPUmlPackageController).
		                   ('Profile' -> OPUmlProfileController) }.
	expectedClasses do: [ :pair |
			| entry |
			entry := palette entries detect: [ :eachEntry | eachEntry label = pair key ].
			entry action value.
			self assert: (palette selectedTool instVarNamed: #factory) value class identicalTo: pair value ].

	profileController := OPUmlPackageDiagramController new
		                     projectController: controller projectController;
		                     model: (OPUMLProfile new name: 'MyProfile');
		                     yourself.
	profilePalette := OPPalette new.
	profileController initializePalette: profilePalette.
	{
		('Stereotype' -> OPUmlStereotypeController).
		('Extension' -> OPUmlExtensionController) } do: [ :pair |
			| entry |
			entry := profilePalette entries detect: [ :eachEntry | eachEntry label = pair key ].
			entry action value.
			self assert: (profilePalette selectedTool instVarNamed: #factory) value class identicalTo: pair value ]
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testInitializeProfilePaletteCreatesClassAndRelationshipStereotypeEntries [

	| profile abstractStereotype relStereotype relBaseAttr palette classEntry relEntry classController assocController mockWorkbench mockForm editor |
	profile := ClClockProfileFactory new createProfile.
	abstractStereotype := OPUMLStereotype new
		                      name: 'AbstractStereo';
		                      isAbstract: true;
		                      yourself.
	profile packagedElements add: abstractStereotype.
	relStereotype := OPUMLStereotype new name: 'IssueAssociation'.
	relStereotype tags at: #implementationClassName put: #IPIssueTag.
	relBaseAttr := OPUMLProperty new
		               name: 'base_Association';
		               type: (OPUMLClass new name: 'Association');
		               yourself.
	relStereotype ownedAttributes add: relBaseAttr.
	profile packagedElements add: relStereotype.
	controller model profileApplications add: (OPUMLProfileApplication new appliedProfile: profile).

	palette := OPPalette new.
	controller initializeProfilesPalette: palette.
	self denyCollection: (palette entries collect: #label) includesAny: #( 'AbstractStereo' ).

	classEntry := palette entries detect: [ :eachEntry | eachEntry label = 'Clock' ].
	relEntry := palette entries detect: [ :eachEntry | eachEntry label = 'IssueAssociation' ].

	self assert: (classEntry tool instVarNamed: #factory) value class identicalTo: OPUmlClassController.
	self assert: (relEntry tool instVarNamed: #factory) value class identicalTo: OPUmlAssociationController.

	classController := OPUmlClassController new
		                   diagramController: controller;
		                   model: (OPUMLClass new name: 'Original');
		                   yourself.
	(classEntry tool instVarNamed: #onComplete) value: classController.
	self assert: classController model name equals: 'Clock'.
	self assertCollection: (classController model appliedStereotypes collect: #class) hasSameElements: { ClClock }.

	mockForm := Mock new.
	mockForm stub focusFirstInput willReturn: nil.
	mockWorkbench := Mock new.
	(mockWorkbench stub openFormOn: Any) willReturn: nil.
	mockWorkbench stub form willReturn: mockForm.
	mockWorkbench stub projectController willReturn: controller projectController.
	editor := (OPEditor on: OPUmlClassEditorPlugin new)
		          workbench: mockWorkbench;
		          yourself.
	controller editor: editor.
	(classEntry tool instVarNamed: #onComplete) value: classController.
	self assert: classController model name equals: 'Clock'.

	assocController := OPUmlAssociationController new
		                   diagramController: controller;
		                   model: (OPUMLAssociation new name: 'Assoc');
		                   yourself.
	(relEntry tool instVarNamed: #onComplete) value: assocController.
	self assertCollection: (assocController model appliedStereotypes collect: #class) hasSameElements: { IPIssueTag }
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testIsSystemModelReturnsFalseWithoutViewModel [

	self
		deny: (OPUmlPackageDiagramController new isSystemModel: OPUMLClass new)
		description: 'Diagram controller without viewModel must return false for isSystemModel:'
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testProfileAppliedRebuildsPaletteWhenEditorPresentAndIsSafeHeadless [

	| mockWorkbench editor clockProfile |
	clockProfile := ClClockProfileFactory new createProfile.
	controller model profileApplications add: (OPUMLProfileApplication new appliedProfile: clockProfile).

	controller viewModel announcer announce: OPUmlProfileApplied new.
	self assert: controller editor identicalTo: nil.

	mockWorkbench := Mock new.
	(mockWorkbench stub openFormOn: Any) willReturn: nil.
	mockWorkbench stub projectController willReturn: controller projectController.
	editor := (OPEditor on: OPUmlClassEditorPlugin new)
		          workbench: mockWorkbench;
		          yourself.
	controller editor: editor.

	controller viewModel announcer announce: OPUmlProfileApplied new.

	self assertCollection: (editor palette entries collect: #label) includesAll: #( 'Class' 'Clock' )
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testShowAllElementsExcludesNavigableAssociationAndExtensionEnds [

	| customerClass orderClass regularAttribute association customerEnd ordersEnd stereotype stereotypeAttribute extension extensionEnd baseEnd renderedModels |
	customerClass := OPUMLClass new name: 'Customer'.
	orderClass := OPUMLClass new name: 'Order'.
	regularAttribute := OPUMLProperty new name: 'code'.
	customerClass ownedAttributes add: regularAttribute.

	association := OPUMLAssociation new name: 'places'.
	customerEnd := OPUMLProperty new
		               name: 'customer';
		               type: customerClass;
		               owningAssociation: association;
		               association: association;
		               yourself.
	ordersEnd := OPUMLProperty new
		             name: 'orders';
		             type: orderClass;
		             owningClass: customerClass;
		             association: association;
		             yourself.
	association memberEnds
		add: customerEnd;
		add: ordersEnd.

	stereotype := OPUMLStereotype new name: 'Audited'.
	stereotypeAttribute := OPUMLProperty new name: 'author'.
	stereotype ownedAttributes add: stereotypeAttribute.

	extension := OPUMLExtension new.
	extensionEnd := OPUMLExtensionEnd new
		                name: 'extension_Audited';
		                type: stereotype;
		                owningAssociation: extension;
		                association: extension;
		                yourself.
	baseEnd := OPUMLProperty new
		           name: 'base_Class';
		           type: customerClass;
		           owningClass: stereotype;
		           association: extension;
		           yourself.
	extension memberEnds
		add: extensionEnd;
		add: baseEnd.
	extension ownedEnd: extensionEnd.

	controller model packagedElements
		add: customerClass;
		add: orderClass;
		add: association;
		add: stereotype;
		add: extension.

	controller showAllElements.

	renderedModels := controller controllers collect: #model.
	self assertCollection: renderedModels includesAll: {
			customerClass.
			orderClass.
			regularAttribute.
			association.
			stereotype.
			stereotypeAttribute.
			extension }.
	self denyCollection: renderedModels includesAny: {
			customerEnd.
			ordersEnd.
			extensionEnd.
			baseEnd }
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testShowClassInDiagram [

	| class renderedModels |
	class := OPUMLClass new.
	controller showWithoutDependentInDiagramModel: class.
	renderedModels := controller canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { class }.
	self assert: (controller hasControllerForModel: class) description: 'Diagram controller must register class controller'
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testShowClassWithAttributeInDiagram [

	| class prop renderedModels |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	prop name: 'prop'.
	class ownedAttributes add: prop.
	controller showInDiagramModel: class.
	renderedModels := controller canvas nodes
		                  select: [ :each | each model isNotNil ]
		                  thenCollect: [ :each | each model modelElement ].
	self assertCollection: renderedModels includesAll: { prop }.
	self assert: (controller hasControllerForModel: prop) description: 'Diagram controller must register attribute controller'
]

{ #category : 'tests' }
OPUmlPackageDiagramControllerTest >> testShowDiagramElementPrunesLegacyAssociationEndAttributeLabel [

	| sourceClass targetClass regularAttribute association sourceEnd targetEnd sourceShape targetShape legacyTargetLabel legacySourceLabel regularLabel |
	sourceClass := OPUMLClass new name: 'Element'.
	targetClass := OPUMLClass new name: 'Comment'.
	regularAttribute := OPUMLProperty new name: 'title'.
	sourceClass ownedAttributes add: regularAttribute.

	association := OPUMLAssociation new name: 'comments'.
	sourceEnd := OPUMLProperty new
		             name: 'owningElement';
		             type: sourceClass;
		             owningClass: targetClass;
		             association: association;
		             yourself.
	targetEnd := OPUMLProperty new
		             name: 'ownedComment';
		             type: targetClass;
		             owningClass: sourceClass;
		             association: association;
		             yourself.
	association memberEnds
		add: sourceEnd;
		add: targetEnd.

	controller model packagedElements
		add: sourceClass;
		add: targetClass;
		add: association.

	sourceShape := OPUmlClassShape new
		               modelElement: sourceClass;
		               owningElement: controller diagramElement;
		               yourself.
	legacyTargetLabel := OPUmlAttributeLabel new
		                     modelElement: targetEnd;
		                     yourself.
	sourceShape addAttribute: legacyTargetLabel.
	regularLabel := OPUmlAttributeLabel new
		                modelElement: regularAttribute;
		                yourself.
	sourceShape addAttribute: regularLabel.

	targetShape := OPUmlClassShape new
		               modelElement: targetClass;
		               owningElement: controller diagramElement;
		               yourself.
	legacySourceLabel := OPUmlAttributeLabel new
		                     modelElement: sourceEnd;
		                     yourself.
	targetShape addAttribute: legacySourceLabel.

	controller diagramFocused.

	self
		deny: (controller hasControllerForModel: targetEnd)
		description: 'Legacy association end attribute must not create a controller'.
	self
		deny: (controller hasControllerForModel: sourceEnd)
		description: 'Legacy bidirectional association end attribute must not create a controller'.
	self
		assert: (controller hasControllerForModel: regularAttribute)
		description: 'Regular class attribute must still create a controller'.
	self assert: sourceShape attributesCompartment ownedElements asArray equals: { regularLabel }.
	self assert: targetShape attributesCompartment identicalTo: nil
]
