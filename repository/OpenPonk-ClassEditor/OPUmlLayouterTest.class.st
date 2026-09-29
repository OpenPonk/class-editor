"
Tests automatic layout algorithms and spatial organization of class shapes and connections in UML class diagrams.
"
Class {
	#name : 'OPUmlLayouterTest',
	#superclass : 'TestCase',
	#instVars : [
		'diagramController',
		'project',
		'model',
		'diagram',
		'undoManager'
	],
	#category : 'OpenPonk-ClassEditor-Tests',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests'
}

{ #category : 'running' }
OPUmlLayouterTest >> setUp [
	| projectController |
	super setUp.
	model := OPUMLPackage new name: 'RootModel'.
	project := OPProject new.
	project addModel: model.
	diagram := OPOpenPonkDiagram forModelElement: model.
	project addDiagram: diagram.
	undoManager := OPUndoManager new.
	projectController := OPProjectController forProject: project.
	projectController instVarNamed: #undoManager put: undoManager.
	diagramController := OPUmlPackageDiagramController new.
	projectController addDiagramController: diagramController.
	diagramController
		canvasPresenter: (OPCanvasPresenter new canvas: RSCanvas new; yourself);
		diagramElement: diagram;
		model: model
]

{ #category : 'running' }
OPUmlLayouterTest >> tearDown [
	undoManager := nil.
	diagramController := nil.
	diagram := nil.
	project := nil.
	model := nil.
	super tearDown
]

{ #category : 'tests' }
OPUmlLayouterTest >> testClassCompartmentWidthMatchesClassWidth [
	| richModel richProject richDiagram projectCtrl richDiagramCtrl classCtrl classShape expectedInnerWidth |
	richModel := OPUmlExamples exampleRichClass.
	richProject := OPProject new.
	richProject addModel: richModel.
	richDiagram := OPOpenPonkDiagram forModelElement: richModel.
	richProject addDiagram: richDiagram.
	projectCtrl := OPProjectController forProject: richProject.
	projectCtrl instVarNamed: #undoManager put: OPUndoManager new.
	richDiagramCtrl := OPUmlPackageDiagramController new.
	projectCtrl addDiagramController: richDiagramCtrl.
	richDiagramCtrl
		canvasPresenter: (OPCanvasPresenter new canvas: RSCanvas new; yourself);
		diagramElement: richDiagram;
		model: richModel.
	richDiagramCtrl showAllElements.

	classCtrl := richDiagramCtrl controllers detect: [ :eachController |
		eachController isKindOf: OPUmlClassController ].
	classShape := classCtrl diagramElement.
	expectedInnerWidth := classShape roassalShape width - classShape leftPadding - classShape rightPadding.

	classShape compartments do: [ :eachCompartment |
		self assert: eachCompartment roassalShape width closeTo: expectedInnerWidth ]
]

{ #category : 'tests' }
OPUmlLayouterTest >> testClassCompartmentsHaveNoOverlapsAndAreMonotonicallyOrdered [
	| richModel richProject richDiagram projectController richDiagramController classController classShape attributesCompartment operationsCompartment attributeItems operationItems allLabels |
	richModel := OPUmlExamples exampleRichClass.
	richProject := OPProject new.
	richProject addModel: richModel.
	richDiagram := OPOpenPonkDiagram forModelElement: richModel.
	richProject addDiagram: richDiagram.
	projectController := OPProjectController forProject: richProject.
	projectController instVarNamed: #undoManager put: OPUndoManager new.
	richDiagramController := OPUmlPackageDiagramController new.
	projectController addDiagramController: richDiagramController.
	richDiagramController
		canvasPresenter: (OPCanvasPresenter new canvas: RSCanvas new; yourself);
		diagramElement: richDiagram;
		model: richModel.

	"Simulate workbench open sequence without manual mouse interaction"
	richDiagramController showAllElements.
	richDiagramController applyDefaultLayout.

	classController := richDiagramController controllers detect: [ :eachController |
		eachController isKindOf: OPUmlClassController ].
	classShape := classController diagramElement.
	attributesCompartment := classShape attributesCompartment.
	operationsCompartment := classShape operationsCompartment.

	self assert: attributesCompartment isNotNil.
	self assert: operationsCompartment isNotNil.

	attributeItems := attributesCompartment ownedElements asArray.
	operationItems := operationsCompartment ownedElements asArray.

	"1. Verify vertical monotonic ordering and absence of overlaps inside attributes"
	1 to: attributeItems size - 1 do: [ :index |
		| currentItem nextItem currentRectangle nextRectangle |
		currentItem := attributeItems at: index.
		nextItem := attributeItems at: index + 1.
		currentRectangle := currentItem roassalShape encompassingRectangle.
		nextRectangle := nextItem roassalShape encompassingRectangle.
		self assert: nextRectangle top >= (currentRectangle bottom - 0.01).
		self deny: ((currentRectangle intersects: nextRectangle) and: [
			(currentRectangle intersect: nextRectangle) height > 0.5 ]) ].

	"2. Verify vertical monotonic ordering and absence of overlaps inside operations"
	1 to: operationItems size - 1 do: [ :index |
		| currentItem nextItem currentRectangle nextRectangle |
		currentItem := operationItems at: index.
		nextItem := operationItems at: index + 1.
		currentRectangle := currentItem roassalShape encompassingRectangle.
		nextRectangle := nextItem roassalShape encompassingRectangle.
		self assert: nextRectangle top >= (currentRectangle bottom - 0.01).
		self deny: ((currentRectangle intersects: nextRectangle) and: [
			(currentRectangle intersect: nextRectangle) height > 0.5 ]) ].

	"3. Verify operations compartment is placed strictly below attributes compartment"
	self assert: operationsCompartment roassalShape encompassingRectangle top
		>= (attributesCompartment roassalShape encompassingRectangle bottom - 0.01).

	"4. Verify cross-compartment pairwise non-intersection"
	allLabels := attributeItems , operationItems.
	1 to: allLabels size do: [ :indexA |
		(indexA + 1) to: allLabels size do: [ :indexB |
			| rectA rectB |
			rectA := (allLabels at: indexA) roassalShape encompassingRectangle.
			rectB := (allLabels at: indexB) roassalShape encompassingRectangle.
			self deny: ((rectA intersects: rectB) and: [ (rectA intersect: rectB) height > 0.5 ]) ] ]
]

{ #category : 'tests' }
OPUmlLayouterTest >> testDefaultLayoutIsUndoable [
	| innerPackage innerClass layouter packageController classController initialPackagePosition initialClassPosition |
	innerPackage := OPUMLPackage new name: 'SubPackage'.
	innerClass := OPUMLClass new name: 'SubClass'.
	innerPackage packagedElements add: innerClass.
	innerClass package: innerPackage.
	model packagedElements add: innerPackage.

	diagramController showAllElements.

	packageController := diagramController controllers detect: [ :eachController |
		eachController model == innerPackage ].
	classController := diagramController controllers detect: [ :eachController |
		eachController model == innerClass ].

	initialPackagePosition := packageController roassalShape position copy.
	initialClassPosition := classController roassalShape position copy.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter defaultLayout.

	self assert: undoManager canUndo.

	diagramController undo.

	self assert: packageController roassalShape position equals: initialPackagePosition.
	self assert: classController roassalShape position equals: initialClassPosition
]

{ #category : 'tests' }
OPUmlLayouterTest >> testMultiLevelPackageEncompassesInnerClassesAfterDefaultLayout [
	| outerPackage innerPackage classA classB generalization layouter outerPackageController innerPackageController classAController classBController |
	outerPackage := OPUMLPackage new name: 'PkgOuter'.
	innerPackage := OPUMLPackage new name: 'PkgInner'.
	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.

	classA package: innerPackage.
	classB package: innerPackage.
	innerPackage packagedElements add: classA.
	innerPackage packagedElements add: classB.

	generalization := OPUMLGeneralization new
		general: classB;
		specific: classA.
	classA generalizations add: generalization.

	innerPackage nestingPackage: outerPackage.
	outerPackage packagedElements add: innerPackage.
	model packagedElements add: outerPackage.

	diagramController showAllElements.

	outerPackageController := diagramController controllers detect: [ :eachController | eachController model == outerPackage ].
	innerPackageController := diagramController controllers detect: [ :eachController | eachController model == innerPackage ].
	classAController := diagramController controllers detect: [ :eachController | eachController model == classA ].
	classBController := diagramController controllers detect: [ :eachController | eachController model == classB ].

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter defaultLayout.

	self assert: (innerPackageController roassalShape encompassingRectangle containsRect: classAController roassalShape encompassingRectangle).
	self assert: (innerPackageController roassalShape encompassingRectangle containsRect: classBController roassalShape encompassingRectangle).
	self assert: (outerPackageController roassalShape encompassingRectangle containsRect: innerPackageController roassalShape encompassingRectangle)
]

{ #category : 'tests' }
OPUmlLayouterTest >> testPackageEncompassesInnerClassesAfterDefaultLayout [
	| innerPackage innerClass layouter packageController classController packageShape classShape |
	innerPackage := OPUMLPackage new name: 'SubPackage'.
	innerClass := OPUMLClass new name: 'SubClass'.
	innerPackage packagedElements add: innerClass.
	innerClass package: innerPackage.
	model packagedElements add: innerPackage.

	diagramController showAllElements.

	packageController := diagramController controllers detect: [ :eachController |
		eachController model == innerPackage ].
	classController := diagramController controllers detect: [ :eachController |
		eachController model == innerClass ].

	packageShape := packageController roassalShape.
	classShape := classController roassalShape.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter defaultLayout.

	self assert: (packageShape encompassingRectangle containsRect: classShape encompassingRectangle)
]
