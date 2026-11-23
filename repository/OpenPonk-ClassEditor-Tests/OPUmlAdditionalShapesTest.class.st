"
Tests rendering, naming, layering, compartment, and serialization behaviors of UML package, enumeration, and generalization label diagram elements.
"
Class {
	#name : 'OPUmlAdditionalShapesTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests-DiagramElements',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'tests' }
OPUmlAdditionalShapesTest >> testEnumerationShapeLiteralsCompartmentAndStonInstVarName [

	| enumeration shape literal literalLabel canvas |
	enumeration := OPUMLEnumeration new name: 'Color'.
	literal := OPUMLEnumerationLiteral new name: 'Red'.
	enumeration ownedLiterals add: literal.
	shape := OPUmlEnumerationShape new
		         modelElement: enumeration;
		         yourself.

	self assert: shape literalsCompartment identicalTo: nil.
	self assert: (shape stonInstVarNameFor: #literals) equals: #literalsCompartment.
	self assert: (shape stonInstVarNameFor: #bounds) equals: #bounds.

	literalLabel := OPUmlEnumerationLiteralLabel new
		                modelElement: literal;
		                yourself.
	shape addLiteral: literalLabel.
	self assert: shape literalsCompartment class equals: OPUmlListCompartment.
	self assertCollection: shape literalsCompartment ownedElements hasSameElements: { literalLabel }.

	canvas := RSCanvas new.
	shape renderIn: canvas.
	shape removeLiteral: literalLabel.
	self assert: shape literalsCompartment identicalTo: nil
]

{ #category : 'tests' }
OPUmlAdditionalShapesTest >> testGeneralizationLabelDefaultText [

	| generalization completeSet disjointSet unnamedSet label |
	generalization := OPUMLGeneralization new.
	completeSet := OPUMLGeneralizationSet new
		               name: 'Phase';
		               isCovering: true;
		               isDisjoint: false;
		               yourself.
	disjointSet := OPUMLGeneralizationSet new
		               name: 'Kind';
		               isCovering: false;
		               isDisjoint: true;
		               yourself.
	unnamedSet := OPUMLGeneralizationSet new
		              isCovering: true;
		              isDisjoint: true;
		              yourself.
	generalization generalizationSets
		add: completeSet;
		add: disjointSet;
		add: unnamedSet.
	label := OPUmlGeneralizationLabel new
		         modelElement: generalization;
		         yourself.

	self assert: label defaultText equals: 'Phase {complete}; Kind {disjoint}; set {complete, disjoint}'
]

{ #category : 'tests' }
OPUmlAdditionalShapesTest >> testPackageShapeNameTextHiddenPackagesPushOrderAndDraggableBlock [

	| packageModel hiddenPackage packageShape childClass childShape canvas draggable |
	packageModel := OPUMLPackage new.
	packageShape := OPUmlPackageShape new
		                modelElement: packageModel;
		                yourself.

	self assertEmpty: packageShape hiddenPackages.
	self assert: packageShape nameText equals: ' '.

	packageModel name: ''.
	self assert: packageShape nameText equals: ' '.

	hiddenPackage := OPUMLPackage new name: 'OuterPkg'.
	packageShape hiddenPackages: { hiddenPackage }.
	packageModel name: 'InnerPkg'.
	self assert: packageShape nameText equals: 'OuterPkg::InnerPkg'.

	"Unrendered pushBack and pushFront must be safe no-ops"
	packageShape pushBack.
	packageShape pushFront.
	self deny: packageShape isRendered description: 'Package shape must remain unrendered after unrendered pushBack/pushFront'.

	canvas := RSCanvas new.
	packageShape renderIn: canvas.
	childClass := OPUMLClass new name: 'ContainedClass'.
	childShape := OPUmlClassShape in: packageShape forModelElement: childClass.
	childShape renderIn: canvas.

	packageShape pushBack.
	self assert: canvas shapes first identicalTo: (packageShape instVarNamed: #ear).
	packageShape pushFront.
	self assert: canvas shapes last identicalTo: (packageShape instVarNamed: #stereotypeLabel).

	draggable := packageShape roassalShape propertyAt: OPRSSelectionDraggable.
	self assertCollection: (draggable shapesToDragInside: packageShape roassalShape) hasSameElements: { childShape roassalShape }
]
