"
Verifies that complex sequences of UML structural edits maintain invariant consistency across undo and redo operations.
"
Class {
	#name : 'OPUmlUndoRedoRegressionTest',
	#superclass : 'TestCase',
	#instVars : [
		'project',
		'diagram',
		'registry',
		'canvas',
		'diagramController',
		'undoManager',
		'model',
		'projectController'
	],
	#category : 'OpenPonk-ClassEditor-Tests-Examples',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Examples'
}

{ #category : 'running' }
OPUmlUndoRedoRegressionTest >> setUp [
	| plugin |
	super setUp.
	model := OPUmlExamples exampleAlcoholAndBarrel.
	project := OPProject new.
	project addModel: model.
	diagram := OPOpenPonkDiagram forModelElement: model.
	project addDiagram: diagram.

	undoManager := OPUndoManager new.
	projectController := OPProjectController forProject: project.
	projectController instVarNamed: #undoManager put: undoManager.
	registry := projectController viewModelRegistry.

	plugin := OPPluginRegistry default pluginFor: model.
	canvas := RSCanvas new.
	diagramController := plugin diagramControllerClass new.
	projectController addDiagramController: diagramController.
	diagramController
		canvasPresenter: (OPCanvasPresenter new canvas: canvas; yourself);
		diagramElement: diagram;
		model: model.

	diagramController showAllElements
]

{ #category : 'running' }
OPUmlUndoRedoRegressionTest >> tearDown [
	projectController ifNotNil: [
		diagramController ifNotNil: [ :currentDiagramController |
			projectController removeDiagramController: currentDiagramController ] ].
	undoManager := nil.
	projectController := nil.
	diagramController := nil.
	canvas := nil.
	registry := nil.
	diagram := nil.
	project := nil.
	model := nil.
	super tearDown
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testAssociationMemberEndsCountOnUndoRedoUndo [
	| association alcoholController |
	association := model packagedElements detect: [ :eachElement |
		(eachElement isKindOf: OPUMLAssociation) and: [
			eachElement memberEnds anySatisfy: [ :eachMemberEnd | eachMemberEnd type name = 'Alcohol' ] ] ].
	alcoholController := diagramController controllerForModel: (model packagedElements detect: [ :eachElement | eachElement name = 'Alcohol' ]).

	diagramController removeModelOfRoassalShape: alcoholController roassalShape.

	[ undoManager undo ] on: Warning do: [ :warning |
		(warning isKindOf: OPModelInvalid)
			ifTrue: [ self fail: 'OPModelInvalid during first undo: ' , warning messageText ]
			ifFalse: [ warning pass ] ].

	undoManager redo.

	[ undoManager undo ] on: Warning do: [ :warning |
		(warning isKindOf: OPModelInvalid)
			ifTrue: [ self fail: 'OPModelInvalid during second undo: ' , warning messageText ]
			ifFalse: [ warning pass ] ].

	self assert: association memberEnds size equals: 2
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testEdgeLabelDragCreatesUndoCommandWithoutSelectionDraggable [

	| associationModel associationController labelElement labelShape |
	associationModel := model packagedElements detect: [ :eachElement | eachElement isKindOf: OPUMLAssociation ].
	associationController := diagramController controllerForModel: associationModel.
	labelElement := associationController diagramElement ownedElements
		                detect: [ :eachElement | eachElement isKindOf: OPEdgeLabel ]
		                ifNone: [ self fail: 'OPEdgeLabel not found on association' ].
	labelShape := labelElement roassalShape.

	self deny: labelShape isSelectionDraggable description: 'Label must not have isSelectionDraggable property due to snapping'.

	labelShape announce: (RSMouseDragStart new
			 position: labelShape position;
			 shape: labelShape;
			 canvas: canvas;
			 yourself).
	labelShape announce: (RSMouseDragging new
			 step: 20 @ 20;
			 position: labelShape position + (20 @ 20);
			 shape: labelShape;
			 canvas: canvas;
			 yourself).
	labelShape announce: (RSMouseDragEnd new
			 position: labelShape position + (20 @ 20);
			 shape: labelShape;
			 canvas: canvas;
			 yourself).

	self assert: undoManager canUndo description: 'Dragging an anchored label must record an undo command'.
	self assert: undoManager undoStack first class equals: OPCompositeCommand.
	self assert: undoManager undoStack first leafCount equals: 1.
	self assert: undoManager undoStack first commands first class equals: OPChangeAnchoredBoundsCommand
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testShowAssociationTransitivelyShowsDependenciesInSingleUndoTransaction [

	| association sourceClass targetClass diagramExplorer |
	association := model packagedElements detect: [ :eachModelElement |
		               (eachModelElement isKindOf: OPUMLAssociation) and: [ eachModelElement memberEnds size = 2 ] ].
	sourceClass := association memberEnds first type.
	targetClass := association memberEnds second type.

	diagramController hideModelFromDiagram: association.
	diagramController hideModelFromDiagram: sourceClass.
	diagramController hideModelFromDiagram: targetClass.
	undoManager clear.

	self
		deny: (diagramController hasControllerForModel: association)
		description: 'Association controller must be hidden before showElements:'.
	self
		deny: (diagramController hasControllerForModel: sourceClass)
		description: 'Source class controller must be hidden before showElements:'.
	self
		deny: (diagramController hasControllerForModel: targetClass)
		description: 'Target class controller must be hidden before showElements:'.

	diagramExplorer := OPDiagramExplorer on: diagramController.
	diagramExplorer showElements: { association }.

	self
		assert: (diagramController hasControllerForModel: association)
		description: 'Association controller must be created by showElements:'.
	self
		assert: (diagramController hasControllerForModel: sourceClass)
		description: 'Source class dependency controller must be created by showElements:'.
	self
		assert: (diagramController hasControllerForModel: targetClass)
		description: 'Target class dependency controller must be created by showElements:'.

	undoManager undo.

	self deny: (diagramController hasControllerForModel: association) description: 'Association controller must be removed on Undo'.
	self
		deny: (diagramController hasControllerForModel: sourceClass)
		description: 'Source class must not remain as an orphan after Undo'.
	self
		deny: (diagramController hasControllerForModel: targetClass)
		description: 'Target class must not remain as an orphan after Undo'.

	undoManager redo.

	self
		assert: (diagramController hasControllerForModel: sourceClass)
		description: 'Source class controller must be restored on Redo'.
	self
		assert: (diagramController hasControllerForModel: targetClass)
		description: 'Target class controller must be restored on Redo'.
	self
		assert: (diagramController hasControllerForModel: association)
		description: 'Association controller must be restored on Redo'.
	self assert: (diagramController controllerForModel: association) roassalShape class equals: OPRSPolyline.
	self
		assert: (diagramController controllerForModel: association) isRendered
		description: 'Association controller must be rendered on Redo'
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testShowElementsWithBoundaryAndNoteRespectsCreationPriority [

	| boundaryElement noteElement classElement explorer |
	boundaryElement := OPBoundary new.
	noteElement := OPNote new.
	classElement := model packagedElements detect: [ :eachModelElement | eachModelElement isKindOf: OPUMLClass ].
	explorer := OPDiagramExplorer on: diagramController.

	explorer showElements: {
			boundaryElement.
			noteElement }.

	self
		assert: (diagramController hasControllerForModel: boundaryElement)
		description: 'Boundary element must have a controller after showElements:'.
	self
		assert: (diagramController hasControllerForModel: noteElement)
		description: 'Note element must have a controller after showElements:'.
	self assert: (registry viewModelFor: boundaryElement) creationPriority equals: 5.
	self assert: (registry viewModelFor: noteElement) creationPriority equals: 10.
	self assert: (registry viewModelFor: classElement) creationPriority equals: 10
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testUndoHideClassRestoresNavigableAssociationAttribute [

	| customerClass orderClass placesAssociation customerProperty ordersProperty diagramExplorer |
	customerClass := OPUMLClass new name: 'Customer'.
	orderClass := OPUMLClass new name: 'Order'.
	model packagedElements add: customerClass.
	model packagedElements add: orderClass.

	placesAssociation := OPUMLAssociation new name: 'places'.
	customerProperty := OPUMLProperty new
		                    name: 'customer';
		                    type: customerClass;
		                    owningAssociation: placesAssociation;
		                    association: placesAssociation.
	ordersProperty := OPUMLProperty new
		                  name: 'orders';
		                  type: orderClass;
		                  association: placesAssociation;
		                  owningClass: customerClass.

	placesAssociation memberEnds: {
			customerProperty.
			ordersProperty }.
	model packagedElements add: placesAssociation.

	diagramController showInDiagramModel: customerClass.
	diagramController showInDiagramModel: orderClass.
	diagramController showInDiagramModel: placesAssociation.
	undoManager clear.

	self
		deny: (diagramController hasControllerForModel: ordersProperty)
		description: 'Navigable association end must not spawn an attribute controller on the diagram'.
	self assertCollection: customerClass ownedAttributes includesAll: { ordersProperty }.

	diagramExplorer := OPDiagramExplorer on: diagramController.
	diagramExplorer hideElement: customerClass.

	self
		deny: (diagramController hasControllerForModel: customerClass)
		description: 'Customer class controller must be removed on hide'.
	self
		deny: (diagramController hasControllerForModel: placesAssociation)
		description: 'Association controller must be removed on hide'.

	undoManager undo.

	self assert: (diagramController hasControllerForModel: customerClass) description: 'Customer class must be restored on undo'.
	self assert: (diagramController hasControllerForModel: placesAssociation) description: 'Association must be restored on undo'.
	self
		deny: (diagramController hasControllerForModel: ordersProperty)
		description: 'Association end must remain off the diagram on undo'.
	self assertCollection: customerClass ownedAttributes includesAll: { ordersProperty }.

	undoManager redo.

	self deny: (diagramController hasControllerForModel: customerClass) description: 'Customer class must be removed on redo'.
	self deny: (diagramController hasControllerForModel: placesAssociation) description: 'Association must be removed on redo'.

	undoManager undo.

	self
		assert: (diagramController hasControllerForModel: customerClass)
		description: 'Customer class must be restored on second undo'.
	self
		assert: (diagramController hasControllerForModel: placesAssociation)
		description: 'Association must be restored on second undo'.
	self
		deny: (diagramController hasControllerForModel: ordersProperty)
		description: 'Association end must remain off the diagram on second undo'
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testUndoRedoOperationCreationInClassCompartment [

	| barrelModel barrelController operationController compartment |
	barrelModel := model packagedElements detect: [ :eachElement | eachElement name = 'Barrel' ].
	barrelController := diagramController controllerForModel: barrelModel.
	self assertEmpty: barrelController model ownedOperations.

	operationController := OPUmlOperationController new.
	barrelController addAsTargetFor: operationController.

	self assert: barrelController model ownedOperations size equals: 1.
	compartment := barrelController diagramElement operationsCompartment.
	self assert: compartment class equals: OPUmlFeaturesListCompartment.
	self assert: compartment ownedElements size equals: 1.

	undoManager undo.
	self assertEmpty: barrelController model ownedOperations.
	self assert: barrelController diagramElement operationsCompartment identicalTo: nil.

	undoManager redo.
	self assert: barrelController model ownedOperations size equals: 1.
	compartment := barrelController diagramElement operationsCompartment.
	self assert: compartment class equals: OPUmlFeaturesListCompartment.
	self assert: compartment ownedElements size equals: 1
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testUndoRestoresClassCompartmentsAndLayout [

	| richModel classModel localProject localDiagram localCanvas localPlugin localDiagramController richController classShape restoredController restoredShape localProjectController localUndoManager |
	richModel := OPUmlExamples exampleRichClass.
	classModel := richModel packagedElements detect: [ :eachElement | eachElement isKindOf: OPUMLClass ].
	localProject := OPProject new.
	localProject addModel: richModel.
	localDiagram := OPOpenPonkDiagram forModelElement: richModel.
	localProject addDiagram: localDiagram.
	localUndoManager := OPUndoManager new.

	localProjectController := OPProjectController forProject: localProject.
	localProjectController instVarNamed: #undoManager put: localUndoManager.

	localPlugin := OPPluginRegistry default pluginFor: richModel.
	localCanvas := RSCanvas new.
	localDiagramController := localPlugin diagramControllerClass new.
	localProjectController addDiagramController: localDiagramController.
	localDiagramController
		canvasPresenter: (OPCanvasPresenter new
				 canvas: localCanvas;
				 yourself);
		diagramElement: localDiagram;
		model: richModel.

	localDiagramController showAllElements.

	richController := localDiagramController controllerForModel: classModel.
	classShape := richController diagramElement.
	self assert: classShape attributesCompartment class equals: OPUmlListCompartment.
	self assert: classShape attributesCompartment ownedElements size equals: 8.

	localDiagramController removeModelOfRoassalShape: richController roassalShape.
	localUndoManager undo.

	restoredController := localDiagramController controllerForModel: classModel.
	restoredShape := restoredController diagramElement.
	self assert: restoredShape attributesCompartment class equals: OPUmlListCompartment.
	self assert: restoredShape attributesCompartment ownedElements size equals: 8.
	self assert: restoredShape operationsCompartment class equals: OPUmlFeaturesListCompartment.
	self assert: restoredShape operationsCompartment ownedElements size equals: 2.
	self assert: restoredShape roassalShape height closeTo: classShape roassalShape height precision: 0.01
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testUndoRestoresStereotypeLabel [

	| alcoholModel alcoholController classShape restoredController restoredShape stereotypeLabel |
	alcoholModel := model packagedElements detect: [ :eachElement | eachElement name = 'Alcohol' ].
	alcoholController := diagramController controllerForModel: alcoholModel.
	classShape := alcoholController diagramElement.
	self denyEmpty: classShape stereotypes.

	diagramController removeModelOfRoassalShape: alcoholController roassalShape.
	self deny: alcoholController isRendered description: 'Alcohol controller must not be rendered after removal'.

	undoManager undo.

	restoredController := diagramController controllerForModel: alcoholModel.
	restoredShape := restoredController diagramElement.
	stereotypeLabel := restoredShape instVarNamed: #stereotypeLabel.
	self assert: stereotypeLabel class equals: OPUmlCompartmentableLabel.
	self assertCollection: restoredShape ownedElements includesAll: { stereotypeLabel }.
	self assert: stereotypeLabel isRendered description: 'StereotypeLabel must be rendered after undo'.
	self assert: stereotypeLabel roassalShape isInACanvas description: 'StereotypeLabel roassalShape must be inside canvas'
]
