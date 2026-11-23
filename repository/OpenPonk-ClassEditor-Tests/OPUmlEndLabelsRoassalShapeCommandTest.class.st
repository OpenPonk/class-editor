"
Tests context-menu commands controlling visibility of UML association end labels, including context eligibility, menu labels, style inheritance, and transactional undo/redo behavior.
"
Class {
	#name : 'OPUmlEndLabelsRoassalShapeCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'diagram',
		'diagramController',
		'undoManager',
		'canvasPresenter',
		'sourceClassController',
		'associationController'
	],
	#category : 'OpenPonk-ClassEditor-Tests-Commands-RoassalShape',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Commands-RoassalShape'
}

{ #category : 'running' }
OPUmlEndLabelsRoassalShapeCommandTest >> createPackageModel [

	| rootPackage sourceClass targetClass association sourceEnd targetEnd |
	rootPackage := OPUMLPackage new name: 'RootPackage'.
	sourceClass := OPUMLClass new name: 'SourceClass'.
	targetClass := OPUMLClass new name: 'TargetClass'.
	association := OPUMLAssociation new name: 'connects'.
	sourceEnd := OPUMLProperty new
		             name: 'sourceRole';
		             type: sourceClass;
		             owningAssociation: association;
		             yourself.
	targetEnd := OPUMLProperty new
		             name: 'targetRole';
		             type: targetClass;
		             owningAssociation: association;
		             yourself.
	association memberEnds: {
			sourceEnd.
			targetEnd }.
	rootPackage packagedElements
		add: sourceClass;
		add: targetClass;
		add: association.
	^ rootPackage
]

{ #category : 'running' }
OPUmlEndLabelsRoassalShapeCommandTest >> setUp [

	| rootPackage projectController |
	super setUp.
	project := OPProject named: 'EndLabelsTestProject'.
	rootPackage := self createPackageModel.
	project addModel: rootPackage.
	diagram := OPOpenPonkDiagram forModelElement: rootPackage.
	project addDiagram: diagram.
	projectController := OPProjectController forProject: project.
	undoManager := projectController undoManager.
	diagramController := OPUmlPackageDiagramController new.
	projectController addDiagramController: diagramController.
	canvasPresenter := OPCanvasPresenter new
		                   canvas: RSCanvas new;
		                   diagramController: diagramController;
		                   yourself.
	diagramController
		workbenchAnnouncer: Announcer new;
		diagramElement: diagram;
		canvasPresenter: canvasPresenter;
		model: rootPackage.
	diagram renderIn: canvasPresenter canvas.
	sourceClassController := diagramController showWithoutDependentInDiagramModel: rootPackage packagedElements first.
	diagramController showWithoutDependentInDiagramModel: rootPackage packagedElements second.
	associationController := diagramController showWithoutDependentInDiagramModel: rootPackage packagedElements third.
	undoManager clear
]

{ #category : 'running' }
OPUmlEndLabelsRoassalShapeCommandTest >> tearDown [

	associationController := nil.
	sourceClassController := nil.
	canvasPresenter := nil.
	undoManager := nil.
	diagramController := nil.
	diagram := nil.
	project := nil.
	super tearDown
]

{ #category : 'tests' }
OPUmlEndLabelsRoassalShapeCommandTest >> testCanBeExecutedInContextAndSupportsHidingLabelEnds [

	| associationShape endLabel nonUmlDiagram emptyDiagram diagramContext assocContext classContext |
	associationShape := associationController diagramElement.
	endLabel := associationShape ownedElements detect: [ :each | each isKindOf: OPUmlAssociationEndLabel ].
	nonUmlDiagram := OPOpenPonkDiagram forModelElement: OPNote new.
	emptyDiagram := OPOpenPonkDiagram new.

	self assert: diagram supportsHidingLabelEnds description: 'UML package diagram must support hiding association end labels'.
	self deny: nonUmlDiagram supportsHidingLabelEnds description: 'Non-UML diagram must not support hiding association end labels'.
	self
		deny: emptyDiagram supportsHidingLabelEnds
		description: 'Diagram without modelElement must not support hiding association end labels'.
	self
		deny: sourceClassController diagramElement supportsHidingLabelEnds
		description: 'Class shape must not support hiding association end labels'.
	self assert: associationShape supportsHidingLabelEnds description: 'Association shape must support hiding association end labels'.
	self assert: endLabel supportsHidingLabelEnds description: 'Association end label must support hiding association end labels'.

	diagramContext := OPRoassalShapeContext for: canvasPresenter of: { canvasPresenter canvas }.
	assocContext := OPRoassalShapeContext for: canvasPresenter of: { associationShape roassalShape }.
	classContext := OPRoassalShapeContext for: canvasPresenter of: { sourceClassController roassalShape }.

	self
		assert: (OPUmlShowEndLabelsRoassalShapeCommand canBeExecutedInContext: diagramContext)
		description: 'Show command must be executable on UML diagram'.
	self
		assert: (OPUmlShowEndLabelsRoassalShapeCommand canBeExecutedInContext: assocContext)
		description: 'Show command must be executable on association shape'.
	self
		deny: (OPUmlShowEndLabelsRoassalShapeCommand canBeExecutedInContext: classContext)
		description: 'Show command must not be executable on class shape'.

	self
		deny: (OPUmlUnsetEndLabelsRoassalShapeCommand canBeExecutedInContext: diagramContext)
		description: 'Unset command must not be executable on root diagram'.
	self
		assert: (OPUmlUnsetEndLabelsRoassalShapeCommand canBeExecutedInContext: assocContext)
		description: 'Unset command must be executable on association shape'
]

{ #category : 'tests' }
OPUmlEndLabelsRoassalShapeCommandTest >> testCommandMetadataIconsAndMenuGroup [

	| activation |
	self assert: OPUmlEndLabelsRoassalShapeCommand isAbstract description: 'Root end labels command must be abstract'.
	self assert: OPUmlSetEndLabelsRoassalShapeCommand isAbstract description: 'Set end labels base command must be abstract'.
	self deny: OPUmlShowEndLabelsRoassalShapeCommand isAbstract description: 'Concrete show command must not be abstract'.
	self deny: OPUmlUnsetEndLabelsRoassalShapeCommand isAbstract description: 'Concrete unset command must not be abstract'.

	activation := OPUmlEndLabelsRoassalShapeCommand contextMenuActivation.
	self assert: activation class equals: CmdContextMenuActivation.
	self assert: OPUmlEndLabelsRoassalShapeMenuGroup new name equals: 'Association end labels'.

	self assert: OPUmlEndLabelsRoassalShapeCommand new basicMenuItemName equals: ''.
	self
		deny: OPUmlEndLabelsRoassalShapeCommand new isCurrentlyActive
		description: 'Base end labels command is never active by default'.
	self assert: OPUmlSetEndLabelsRoassalShapeCommand styleState equals: #''.
	self assert: OPUmlSetEndLabelsRoassalShapeCommand new styleState equals: #''.

	self assert: OPUmlHideEndLabelsRoassalShapeCommand new basicMenuItemName equals: 'Hide all'.
	self assert: OPUmlHideEndLabelsRoassalShapeCommand new description equals: 'Hide all association end labels'.
	self assert: OPUmlHideEndLabelsRoassalShapeCommand new defaultMenuIconFormSet class identicalTo: FormSet.

	self assert: OPUmlHideSameAsClassEndLabelsRoassalShapeCommand new basicMenuItemName equals: 'Hide same as class name'.
	self
		assert: OPUmlHideSameAsClassEndLabelsRoassalShapeCommand new description
		equals: 'Hide association end labels with same text as name of its connected class'.
	self assert: OPUmlHideSameAsClassEndLabelsRoassalShapeCommand new defaultMenuIconFormSet class identicalTo: FormSet.

	self assert: OPUmlShowEndLabelsRoassalShapeCommand new basicMenuItemName equals: 'Show all'.
	self assert: OPUmlShowEndLabelsRoassalShapeCommand new description equals: 'Show all association end labels'.
	self assert: OPUmlShowEndLabelsRoassalShapeCommand new defaultMenuIconFormSet class identicalTo: FormSet.

	self assert: OPUmlUnsetEndLabelsRoassalShapeCommand new basicMenuItemName equals: 'Use diagram-level setting'.
	self
		assert: OPUmlUnsetEndLabelsRoassalShapeCommand new description
		equals: 'Adopt option picked for the entire diagram, instead of overriding it'
]

{ #category : 'tests' }
OPUmlEndLabelsRoassalShapeCommandTest >> testDefaultMenuItemNameStatesDiagramInheritanceAndDirectExecution [

	| associationShape endLabel diagramContext assocContext classContext hideDiagramCmd hideAssocCmd showAssocCmd hideSameAssocCmd unsetAssocCmd emptySetCmd emptyUnsetCmd |
	associationShape := associationController diagramElement.
	endLabel := associationShape ownedElements detect: [ :each | each isKindOf: OPUmlAssociationEndLabel ].
	diagramContext := OPRoassalShapeContext for: canvasPresenter of: { canvasPresenter canvas }.
	assocContext := OPRoassalShapeContext for: canvasPresenter of: { associationShape roassalShape }.
	classContext := OPRoassalShapeContext for: canvasPresenter of: { sourceClassController roassalShape }.

	hideSameAssocCmd := OPUmlHideSameAsClassEndLabelsRoassalShapeCommand new.
	hideSameAssocCmd readParametersFromContext: assocContext.
	unsetAssocCmd := OPUmlUnsetEndLabelsRoassalShapeCommand new.
	unsetAssocCmd readParametersFromContext: assocContext.
	self assert: hideSameAssocCmd defaultMenuItemName equals: 'Hide same as class name (active)'.
	self assert: unsetAssocCmd defaultMenuItemName equals: 'Use diagram-level setting [selected]'.

	hideDiagramCmd := OPUmlHideEndLabelsRoassalShapeCommand new.
	hideDiagramCmd readParametersFromContext: diagramContext.
	self assert: hideDiagramCmd defaultMenuItemName equals: 'Hide all'.
	hideDiagramCmd execute.
	self assert: hideDiagramCmd defaultMenuItemName equals: 'Hide all [selected]'.
	self assert: endLabel roassalShape text equals: ''.

	hideAssocCmd := OPUmlHideEndLabelsRoassalShapeCommand new.
	hideAssocCmd readParametersFromContext: assocContext.
	self assert: hideAssocCmd defaultMenuItemName equals: 'Hide all (active)'.

	showAssocCmd := OPUmlShowEndLabelsRoassalShapeCommand new.
	showAssocCmd readParametersFromContext: assocContext.
	showAssocCmd stub undoManager willReturn: nil.
	showAssocCmd execute.
	self assert: showAssocCmd defaultMenuItemName equals: 'Show all [selected]'.
	self assert: unsetAssocCmd defaultMenuItemName equals: 'Use diagram-level setting'.
	self assert: endLabel roassalShape text equals: endLabel modelElement notationStringAsRoleName.

	unsetAssocCmd stub undoManager willReturn: nil.
	unsetAssocCmd execute.
	self assert: unsetAssocCmd defaultMenuItemName equals: 'Use diagram-level setting [selected]'.
	self assert: endLabel roassalShape text equals: ''.

	emptySetCmd := OPUmlShowEndLabelsRoassalShapeCommand new.
	emptySetCmd readParametersFromContext: classContext.
	emptySetCmd execute.
	emptyUnsetCmd := OPUmlUnsetEndLabelsRoassalShapeCommand new.
	emptyUnsetCmd readParametersFromContext: classContext.
	emptyUnsetCmd execute.

	diagram showAssociationEndLabels: OPUmlShowEndLabelsRoassalShapeCommand styleState.
	self assert: diagram showAssociationEndLabels equals: OPUmlShowEndLabelsRoassalShapeCommand styleState.
	diagram unsetAssociationEndLabels.
	self assert: diagram showAssociationEndLabels equals: OPUmlEndLabelsRoassalShapeCommand defaultResultingShowState
]

{ #category : 'tests' }
OPUmlEndLabelsRoassalShapeCommandTest >> testSetAndUnsetCommandsAreUndoableAndRedoable [

	| associationShape endLabel toolContext hideCommand unsetCommand |
	associationShape := associationController diagramElement.
	endLabel := associationShape ownedElements detect: [ :each | each isKindOf: OPUmlAssociationEndLabel ].
	toolContext := OPRoassalShapeContext for: canvasPresenter of: { associationShape roassalShape }.

	hideCommand := OPUmlHideEndLabelsRoassalShapeCommand new.
	hideCommand readParametersFromContext: toolContext.
	hideCommand execute.

	self assert: associationShape showAssociationEndLabels equals: OPUmlHideEndLabelsRoassalShapeCommand styleState.
	self assert: endLabel roassalShape text equals: ''.
	self assert: undoManager canUndo description: 'Setting association end label visibility must be recorded in undoManager'.

	undoManager undo.
	self assert: associationShape showAssociationEndLabels equals: OPUmlEndLabelsRoassalShapeCommand defaultResultingShowState.
	self assert: endLabel roassalShape text equals: endLabel modelElement notationStringAsRoleName.

	undoManager redo.
	self assert: associationShape showAssociationEndLabels equals: OPUmlHideEndLabelsRoassalShapeCommand styleState.
	self assert: endLabel roassalShape text equals: ''.

	unsetCommand := OPUmlUnsetEndLabelsRoassalShapeCommand new.
	unsetCommand readParametersFromContext: toolContext.
	unsetCommand execute.

	self assert: associationShape showAssociationEndLabels equals: OPUmlEndLabelsRoassalShapeCommand defaultResultingShowState.
	self assert: endLabel roassalShape text equals: endLabel modelElement notationStringAsRoleName.

	undoManager undo.
	self assert: associationShape showAssociationEndLabels equals: OPUmlHideEndLabelsRoassalShapeCommand styleState.
	self assert: endLabel roassalShape text equals: ''.

	undoManager redo.
	self assert: associationShape showAssociationEndLabels equals: OPUmlEndLabelsRoassalShapeCommand defaultResultingShowState
]

{ #category : 'tests' }
OPUmlEndLabelsRoassalShapeCommandTest >> testSetIsCurrentlySelectedIsFalseWhenNoApplicableElements [

	| classContext command |
	classContext := OPRoassalShapeContext for: canvasPresenter of: { sourceClassController roassalShape }.
	command := OPUmlHideEndLabelsRoassalShapeCommand new.
	command readParametersFromContext: classContext.
	self
		deny: command isCurrentlySelected
		description: 'isCurrentlySelected must not return vacuous true when applicableDiagramElements is empty'
]

{ #category : 'tests' }
OPUmlEndLabelsRoassalShapeCommandTest >> testStyleStateSymbolsMatchSemantics [

	self assert: OPUmlHideEndLabelsRoassalShapeCommand styleState equals: #hide.
	self assert: OPUmlShowEndLabelsRoassalShapeCommand styleState equals: #show.
	self assert: OPUmlHideSameAsClassEndLabelsRoassalShapeCommand styleState equals: #hideSame
]

{ #category : 'tests' }
OPUmlEndLabelsRoassalShapeCommandTest >> testUnsetCanBeExecutedRejectsMixedNonSupportingAndDiagramSelection [

	| mixedContext |
	mixedContext := OPRoassalShapeContext for: canvasPresenter of: {
			                canvasPresenter canvas.
			                sourceClassController roassalShape }.
	self
		deny: (OPUmlUnsetEndLabelsRoassalShapeCommand canBeExecutedInContext: mixedContext)
		description:
		'Unset command must not be executable when no single element both supports hiding label ends and has an owning element'
]
