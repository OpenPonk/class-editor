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
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPUmlUndoRedoRegressionTest >> setUp [
	| plugin |
	super setUp.
	model := OntoUMLExamples exampleSubQuantityContainment.
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
	self assert: undoManager undoStack first leafCount > 0
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

	self deny: (diagramController hasControllerForModel: association).
	self deny: (diagramController hasControllerForModel: sourceClass).
	self deny: (diagramController hasControllerForModel: targetClass).

	diagramExplorer := OPDiagramExplorer on: diagramController.
	diagramExplorer showElements: { association }.

	self assert: (diagramController hasControllerForModel: association).
	self assert: (diagramController hasControllerForModel: sourceClass).
	self assert: (diagramController hasControllerForModel: targetClass).

	undoManager undo.

	self deny: (diagramController hasControllerForModel: association)
		description: 'Association controller must be removed on Undo'.
	self deny: (diagramController hasControllerForModel: sourceClass)
		description: 'Source class must not remain as an orphan after Undo'.
	self deny: (diagramController hasControllerForModel: targetClass)
		description: 'Target class must not remain as an orphan after Undo'.

	undoManager redo.

	self assert: (diagramController hasControllerForModel: sourceClass).
	self assert: (diagramController hasControllerForModel: targetClass).
	self assert: (diagramController hasControllerForModel: association).
	self assert: (diagramController controllerForModel: association) roassalShape isNotNil
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testShowElementsWithBoundaryAndNoteRespectsCreationPriority [
	| boundaryElement noteElement classElement explorer |
	boundaryElement := OPBoundary new.
	noteElement := OPNote new.
	classElement := model packagedElements detect: [ :eachModelElement | eachModelElement isKindOf: OPUMLClass ].
	explorer := OPDiagramExplorer on: diagramController.

	explorer showElements: { boundaryElement . noteElement }.

	self assert: (diagramController hasControllerForModel: boundaryElement).
	self assert: (diagramController hasControllerForModel: noteElement).
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
		association: placesAssociation.
	ordersProperty := OPUMLProperty new
		name: 'orders';
		type: orderClass;
		association: placesAssociation;
		owningClass: customerClass.
	customerClass ownedAttributes add: ordersProperty.

	placesAssociation memberEnds: { customerProperty . ordersProperty }.
	placesAssociation ownedEnds: { customerProperty }.
	placesAssociation navigableOwnedEnds: { ordersProperty }.
	model packagedElements add: placesAssociation.

	diagramController showInDiagramModel: customerClass.
	diagramController showInDiagramModel: orderClass.
	diagramController showInDiagramModel: placesAssociation.
	undoManager clear.

	self assert: (diagramController hasControllerForModel: ordersProperty)
		description: 'Orders property must have a controller before hide'.

	diagramExplorer := OPDiagramExplorer on: diagramController.
	diagramExplorer hideElement: customerClass.

	self deny: (diagramController hasControllerForModel: customerClass)
		description: 'Customer class controller must be removed on hide'.
	self deny: (diagramController hasControllerForModel: placesAssociation)
		description: 'Association controller must be removed on hide'.
	self deny: (diagramController hasControllerForModel: ordersProperty)
		description: 'Orders property controller must be removed on hide'.

	undoManager undo.

	self assert: (diagramController hasControllerForModel: customerClass)
		description: 'Customer class must be restored on undo'.
	self assert: (diagramController hasControllerForModel: placesAssociation)
		description: 'Association must be restored on undo'.
	self assert: (diagramController hasControllerForModel: ordersProperty)
		description: 'Orders property must be restored in Customer class on undo'.
	self assert: (diagramController controllerForModel: ordersProperty) isRendered
		description: 'Orders property controller must be rendered on undo'.

	undoManager redo.

	self deny: (diagramController hasControllerForModel: customerClass)
		description: 'Customer class must be removed on redo'.
	self deny: (diagramController hasControllerForModel: placesAssociation)
		description: 'Association must be removed on redo'.
	self deny: (diagramController hasControllerForModel: ordersProperty)
		description: 'Orders property must be removed on redo'.

	undoManager undo.

	self assert: (diagramController hasControllerForModel: customerClass).
	self assert: (diagramController hasControllerForModel: placesAssociation).
	self assert: (diagramController hasControllerForModel: ordersProperty).
	self assert: (diagramController controllerForModel: ordersProperty) isRendered
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testUndoRedoOperationCreationInClassCompartment [
	| barrelModel barrelController operationController compartment |
	barrelModel := model packagedElements detect: [ :eachElement | eachElement name = 'Barrel' ].
	barrelController := diagramController controllerForModel: barrelModel.
	self assert: barrelController model ownedOperations isEmpty description: 'Class must initially have no operations'.

	operationController := OPUmlOperationController new.
	barrelController addAsTargetFor: operationController.

	self assert: barrelController model ownedOperations size equals: 1.
	compartment := barrelController diagramElement operations.
	self assert: compartment isNotNil description: 'Operations compartment must exist after operation creation'.
	self assert: compartment ownedElements size equals: 1.

	undoManager undo.
	self assert: barrelController model ownedOperations isEmpty description: 'Class operations must be empty after undo'.
	self assert: (barrelController diagramElement operations ifNotNil: [ :eachCompartment | eachCompartment ownedElements size ] ifNil: [ 0 ]) equals: 0.

	undoManager redo.
	self assert: barrelController model ownedOperations size equals: 1.
	compartment := barrelController diagramElement operations.
	self assert: compartment isNotNil description: 'Operations compartment must exist after redo'.
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
		canvasPresenter: (OPCanvasPresenter new canvas: localCanvas; yourself);
		diagramElement: localDiagram;
		model: richModel.

	localDiagramController showAllElements.

	richController := localDiagramController controllerForModel: classModel.
	classShape := richController diagramElement.
	self assert: classShape attributes isNotNil.
	self assert: classShape attributes ownedElements isNotEmpty.

	localDiagramController removeModelOfRoassalShape: richController roassalShape.
	localUndoManager undo.

	restoredController := localDiagramController controllerForModel: classModel.
	restoredShape := restoredController diagramElement.
	self assert: restoredShape attributes isNotNil description: 'Attributes compartment must not be nil after undo'.
	self assert: restoredShape attributes ownedElements isNotEmpty description: 'Attributes compartment must contain attributes'.
	self assert: restoredShape operations isNotNil description: 'Operations compartment must not be nil after undo'.
	self assert: restoredShape operations ownedElements isNotEmpty description: 'Operations compartment must contain operations'.
	self assert: restoredShape roassalShape height > 100 description: 'Class height must adapt to content extent'
]

{ #category : 'tests' }
OPUmlUndoRedoRegressionTest >> testUndoRestoresStereotypeLabel [
	| alcoholModel alcoholController classShape restoredController restoredShape stereotypeLabel |
	alcoholModel := model packagedElements detect: [ :eachElement | eachElement name = 'Alcohol' ].
	alcoholController := diagramController controllerForModel: alcoholModel.
	classShape := alcoholController diagramElement.
	self assert: classShape stereotypes isNotEmpty.

	diagramController removeModelOfRoassalShape: alcoholController roassalShape.
	self deny: alcoholController isRendered.

	undoManager undo.

	restoredController := diagramController controllerForModel: alcoholModel.
	restoredShape := restoredController diagramElement.
	stereotypeLabel := restoredShape instVarNamed: #stereotypeLabel.
	self assert: stereotypeLabel isNotNil description: 'StereotypeLabel must not be nil after undo'.
	self assert: stereotypeLabel isRendered description: 'StereotypeLabel must be rendered after undo'.
	self assert: stereotypeLabel roassalShape isInACanvas description: 'StereotypeLabel roassalShape must be inside canvas'
]
