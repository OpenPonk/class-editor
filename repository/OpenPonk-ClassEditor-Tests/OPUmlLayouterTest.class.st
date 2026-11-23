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
	#category : 'OpenPonk-ClassEditor-Tests-Plugin',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Plugin'
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
OPUmlLayouterTest >> testAllNodesReturnsRenderedNodeShapes [

	| classA classB layouter nodes |
	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	model packagedElements
		add: classA;
		add: classB.
	diagramController showAllElements.

	layouter := OPUmlLayouter new diagramController: diagramController.
	nodes := layouter allNodes.
	self assert: nodes size equals: 2.
	self assertCollection: nodes hasSameElements: {
			(diagramController controllerForModel: classA) roassalShape.
			(diagramController controllerForModel: classB) roassalShape }
]

{ #category : 'tests' }
OPUmlLayouterTest >> testCircleLayoutGridLayoutAndTreeLayoutPositionNodes [

	| parentClass childClass siblingClass generalization1 generalization2 layouter parentShape childShape |
	parentClass := OPUMLClass new name: 'Parent'.
	childClass := OPUMLClass new name: 'Child'.
	siblingClass := OPUMLClass new name: 'Sibling'.
	generalization1 := OPUMLGeneralization new
		                   general: parentClass;
		                   specific: childClass;
		                   yourself.
	childClass generalizations add: generalization1.
	generalization2 := OPUMLGeneralization new
		                   general: parentClass;
		                   specific: siblingClass;
		                   yourself.
	siblingClass generalizations add: generalization2.
	model packagedElements
		add: parentClass;
		add: childClass;
		add: siblingClass.
	diagramController showAllElements.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter circleLayout.
	self assert: undoManager canUndo description: 'Circle layout must record an undoable command'.

	layouter gridLayout.
	self assert: undoManager canUndo description: 'Grid layout must record an undoable command'.

	layouter treeLayout.
	parentShape := (diagramController controllerForModel: parentClass) roassalShape.
	childShape := (diagramController controllerForModel: childClass) roassalShape.
	self
		assert: parentShape position y < childShape position y
		description: 'Parent class must be positioned above child class in acyclic tree layout'
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
		canvasPresenter: (OPCanvasPresenter new
				 canvas: RSCanvas new;
				 yourself);
		diagramElement: richDiagram;
		model: richModel.

	"Simulate workbench open sequence without manual mouse interaction"
	richDiagramController showAllElements.
	richDiagramController applyDefaultLayout.

	classController := richDiagramController controllers detect: [ :eachController | eachController isKindOf: OPUmlClassController ].
	classShape := classController diagramElement.
	attributesCompartment := classShape attributesCompartment.
	operationsCompartment := classShape operationsCompartment.

	self assert: attributesCompartment class equals: OPUmlListCompartment.
	self assert: operationsCompartment class equals: OPUmlFeaturesListCompartment.

	attributeItems := attributesCompartment ownedElements asArray.
	operationItems := operationsCompartment ownedElements asArray.

	"1. Verify vertical monotonic ordering and absence of overlaps inside attributes"
	1 to: attributeItems size - 1 do: [ :index |
			| currentItem nextItem currentRectangle nextRectangle |
			currentItem := attributeItems at: index.
			nextItem := attributeItems at: index + 1.
			currentRectangle := currentItem roassalShape encompassingRectangle.
			nextRectangle := nextItem roassalShape encompassingRectangle.
			self
				assert: nextRectangle top >= (currentRectangle bottom - 0.01)
				description: 'Attribute compartment items must be vertically ordered from top to bottom'.
			self
				deny: ((currentRectangle intersects: nextRectangle) and: [ (currentRectangle intersect: nextRectangle) height > 0.5 ])
				description: 'Adjacent attribute compartment items must not vertically overlap' ].

	"2. Verify vertical monotonic ordering and absence of overlaps inside operations"
	1 to: operationItems size - 1 do: [ :index |
			| currentItem nextItem currentRectangle nextRectangle |
			currentItem := operationItems at: index.
			nextItem := operationItems at: index + 1.
			currentRectangle := currentItem roassalShape encompassingRectangle.
			nextRectangle := nextItem roassalShape encompassingRectangle.
			self
				assert: nextRectangle top >= (currentRectangle bottom - 0.01)
				description: 'Operation compartment items must be vertically ordered from top to bottom'.
			self
				deny: ((currentRectangle intersects: nextRectangle) and: [ (currentRectangle intersect: nextRectangle) height > 0.5 ])
				description: 'Adjacent operation compartment items must not vertically overlap' ].

	"3. Verify operations compartment is placed strictly below attributes compartment"
	self
		assert: operationsCompartment roassalShape encompassingRectangle top
			>= (attributesCompartment roassalShape encompassingRectangle bottom - 0.01)
		description: 'Operations compartment must be placed below attributes compartment'.

	"4. Verify cross-compartment pairwise non-intersection"
	allLabels := attributeItems , operationItems.
	1 to: allLabels size do: [ :indexA |
			indexA + 1 to: allLabels size do: [ :indexB |
					| rectA rectB |
					rectA := (allLabels at: indexA) roassalShape encompassingRectangle.
					rectB := (allLabels at: indexB) roassalShape encompassingRectangle.
					self
						deny: ((rectA intersects: rectB) and: [ (rectA intersect: rectB) height > 0.5 ])
						description: 'Labels across attribute and operation compartments must not vertically overlap' ] ]
]

{ #category : 'tests' }
OPUmlLayouterTest >> testCyclicDominanceTreeLayoutWithInnerPackageIsUndoable [

	| innerPackage innerClass classA classB generalizationAB generalizationBA layouter innerClassShape initialInnerClassPosition |
	innerPackage := OPUMLPackage new name: 'InnerPkg'.
	innerClass := OPUMLClass new name: 'InnerCls'.
	innerClass package: innerPackage.
	innerPackage packagedElements add: innerClass.

	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	generalizationAB := OPUMLGeneralization new
		                    general: classB;
		                    specific: classA;
		                    yourself.
	classA generalizations add: generalizationAB.
	generalizationBA := OPUMLGeneralization new
		                    general: classA;
		                    specific: classB;
		                    yourself.
	classB generalizations add: generalizationBA.

	model packagedElements
		add: innerPackage;
		add: classA;
		add: classB.

	diagramController showAllElements.
	innerClassShape := (diagramController controllerForModel: innerClass) roassalShape.
	initialInnerClassPosition := innerClassShape position copy.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter dominanceTreeLayout.
	self assert: undoManager canUndo description: 'Cyclic dominance tree layout fallback must be undoable'.

	diagramController undo.
	self assert: innerClassShape position equals: initialInnerClassPosition
]

{ #category : 'tests' }
OPUmlLayouterTest >> testCyclicSugiyamaLayoutFallsBackToGridLayoutAndIsUndoable [

	| innerPackage innerClass classA classB generalizationAB generalizationBA layouter innerClassShape initialInnerClassPosition |
	innerPackage := OPUMLPackage new name: 'InnerPkg'.
	innerClass := OPUMLClass new name: 'InnerCls'.
	innerClass package: innerPackage.
	innerPackage packagedElements add: innerClass.

	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	generalizationAB := OPUMLGeneralization new
		                    general: classB;
		                    specific: classA;
		                    yourself.
	classA generalizations add: generalizationAB.
	generalizationBA := OPUMLGeneralization new
		                    general: classA;
		                    specific: classB;
		                    yourself.
	classB generalizations add: generalizationBA.

	model packagedElements
		add: innerPackage;
		add: classA;
		add: classB.
	diagramController showAllElements.
	innerClassShape := (diagramController controllerForModel: innerClass) roassalShape.
	initialInnerClassPosition := innerClassShape position copy.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter sugiyamaLayout.
	self assert: undoManager canUndo description: 'Cyclic Sugiyama layout fallback must be undoable'.

	diagramController undo.
	self assert: innerClassShape position equals: initialInnerClassPosition
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

	packageController := diagramController controllers detect: [ :eachController | eachController model == innerPackage ].
	classController := diagramController controllers detect: [ :eachController | eachController model == innerClass ].

	initialPackagePosition := packageController roassalShape position copy.
	initialClassPosition := classController roassalShape position copy.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter defaultLayout.

	self assert: undoManager canUndo description: 'Applying default layout must record an undoable command'.

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

	self
		assert:
		(innerPackageController roassalShape encompassingRectangle containsRect: classAController roassalShape encompassingRectangle)
		description: 'Inner package bounds must encompass ClassA after default layout'.
	self
		assert:
		(innerPackageController roassalShape encompassingRectangle containsRect: classBController roassalShape encompassingRectangle)
		description: 'Inner package bounds must encompass ClassB after default layout'.
	self
		assert:
		(outerPackageController roassalShape encompassingRectangle containsRect:
			 innerPackageController roassalShape encompassingRectangle)
		description: 'Outer package bounds must encompass inner package after default layout'
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

	packageController := diagramController controllers detect: [ :eachController | eachController model == innerPackage ].
	classController := diagramController controllers detect: [ :eachController | eachController model == innerClass ].

	packageShape := packageController roassalShape.
	classShape := classController roassalShape.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter defaultLayout.

	self
		assert: (packageShape encompassingRectangle containsRect: classShape encompassingRectangle)
		description: 'Package bounds must encompass inner class after default layout'
]

{ #category : 'tests' }
OPUmlLayouterTest >> testSugiyamaLayoutWithSelfLoopAssociation [

	| parentClass childClass generalization selfAssociation sourceEnd targetEnd layouter parentShape childShape |
	parentClass := OPUMLClass new name: 'Person'.
	childClass := OPUMLClass new name: 'Nurse'.
	model packagedElements
		add: parentClass;
		add: childClass.

	generalization := OPUMLGeneralization new
		                  general: parentClass;
		                  specific: childClass.
	childClass generalizations add: generalization.

	selfAssociation := OPUMLAssociation new name: 'isCompatibleDonor'.
	sourceEnd := OPUMLProperty new
		             name: 'donor';
		             owningAssociation: selfAssociation;
		             type: parentClass.
	targetEnd := OPUMLProperty new
		             name: 'recipient';
		             owningAssociation: selfAssociation;
		             type: parentClass.
	selfAssociation memberEnds addAll: selfAssociation ownedEnds.
	model packagedElements add: selfAssociation.

	diagramController showAllElements.

	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter sugiyamaLayout.

	parentShape := (diagramController controllerForModel: parentClass) roassalShape.
	childShape := (diagramController controllerForModel: childClass) roassalShape.
	self
		assert: parentShape position y < childShape position y
		description: 'Parent class must be positioned above child class in Sugiyama layout'
]

{ #category : 'tests' }
OPUmlLayouterTest >> testTreeLayoutWithGeneralizationCycleFallsBackToGridLayout [

	| classA classB classC generalizationAB generalizationBA generalizationCA layouter shapeA shapeB shapeC distinctYCount |
	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	classC := OPUMLClass new name: 'ClassC'.
	generalizationAB := OPUMLGeneralization new
		                    general: classB;
		                    specific: classA;
		                    yourself.
	classA generalizations add: generalizationAB.
	generalizationBA := OPUMLGeneralization new
		                    general: classA;
		                    specific: classB;
		                    yourself.
	classB generalizations add: generalizationBA.
	generalizationCA := OPUMLGeneralization new
		                    general: classA;
		                    specific: classC;
		                    yourself.
	classC generalizations add: generalizationCA.

	model packagedElements
		add: classA;
		add: classB;
		add: classC.

	diagramController showAllElements.
	layouter := OPUmlLayouter new diagramController: diagramController.
	layouter treeLayout.

	shapeA := (diagramController controllerForModel: classA) roassalShape.
	shapeB := (diagramController controllerForModel: classB) roassalShape.
	shapeC := (diagramController controllerForModel: classC) roassalShape.
	distinctYCount := {
		                  shapeA position y rounded.
		                  shapeB position y rounded.
		                  shapeC position y rounded } asSet size.
	self
		assert: distinctYCount <= 2
		description: 'Grid layout fallback on 3 classes must arrange them in at most 2 rows rather than a 3-level tree'
]
