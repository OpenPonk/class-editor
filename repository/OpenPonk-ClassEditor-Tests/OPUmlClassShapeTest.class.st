"
I am a unit test class verifying the rendering and containment behavior of OPUmlClassShape, inheriting compartment testing from OPAbstractUmlCompartmentableShapeTest.
"
Class {
	#name : 'OPUmlClassShapeTest',
	#superclass : 'OPAbstractUmlCompartmentableShapeTest',
	#category : 'OpenPonk-ClassEditor-Tests-DiagramElements',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'DiagramElements'
}

{ #category : 'instance creation' }
OPUmlClassShapeTest >> modelClass [

	^ OPUMLClass
]

{ #category : 'hooks' }
OPUmlClassShapeTest >> shapeClass [

	^ OPUmlClassShape
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testClassItemListCompartmentSortHandlesNilNamesAndTieBreaksByUuid [

	| compartment staticItem unnamedItem namedFirst namedSecond sortedModels |
	compartment := OPUmlClassItemListCompartment new.
	staticItem := OPUMLProperty new
		              name: 'zeta';
		              isStatic: true;
		              yourself.
	unnamedItem := OPUMLProperty new.
	namedFirst := OPUMLProperty new
		              name: 'alpha';
		              uuid: (UUID fromString: '00000000-0000-0000-0000-000000000001');
		              yourself.
	namedSecond := OPUMLProperty new
		               name: 'alpha';
		               uuid: (UUID fromString: '00000000-0000-0000-0000-000000000002');
		               yourself.
	{
		namedSecond.
		namedFirst.
		unnamedItem.
		staticItem } do: [ :eachProperty | OPUmlAttributeLabel in: compartment forModelElement: eachProperty ].

	compartment sortOwnedElements.
	sortedModels := compartment ownedElements collect: #modelElement.
	self assert: sortedModels asArray equals: {
			staticItem.
			unnamedItem.
			namedFirst.
			namedSecond }
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testClassifierNameLabelAndStereotypesLabel [

	| nameLabel hiddenPackage stereotypeLabel stereotypeClass |
	model name: nil.
	shape modelElement: model.
	nameLabel := OPUmlClassifierNameLabel in: shape forModelElement: model.
	self assertEmpty: nameLabel attachedShapes.
	self assert: nameLabel defaultText equals: ' '.

	model name: ''.
	self assert: nameLabel defaultText equals: ' '.

	hiddenPackage := OPUMLPackage new name: 'HiddenPkg'.
	shape hiddenPackages: { hiddenPackage }.
	model name: 'VisibleClass'.
	self assert: nameLabel defaultText equals: 'HiddenPkg::VisibleClass'.

	nameLabel translateTo: 100 @ 100.
	self assert: nameLabel defaultText equals: 'HiddenPkg::VisibleClass'.

	stereotypeLabel := OPUmlAppliedStereotypesLabel new
		                   modelElement: model;
		                   yourself.
	self assert: stereotypeLabel defaultText equals: ''.

	stereotypeClass := Object newAnonymousSubclass.
	stereotypeClass addSlot: #umlClassName => InstanceVariableSlot.
	stereotypeClass compile: 'umlClassName ^ umlClassName' classified: 'accessing'.
	stereotypeClass compile: 'umlClassName: aSymbol umlClassName := aSymbol' classified: 'accessing'.
	model appliedStereotypes
		add: (stereotypeClass new
				 umlClassName: #Kind;
				 yourself);
		add: (stereotypeClass new
				 umlClassName: #Subkind;
				 yourself).
	self assert: stereotypeLabel defaultText equals: '«Kind, Subkind»'
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testName [

	| labels label |
	model name: 'ClassName'.
	model isAbstract: false.
	shape modelElement: model.
	shape renderIn: canvas.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'ClassName'.
	self assert: label emphasis equals: TextEmphasis normal.

	model isAbstract: true.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'ClassName'.
	self assert: label emphasis equals: TextEmphasis italic.

	model name: 'Name2'.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'Name2'.
	self assert: label emphasis equals: TextEmphasis italic.

	model isAbstract: false.
	shape modelChanged.

	labels := canvas deepShapes select: #isLabel.
	self assert: labels size equals: 1.
	label := labels anyOne.

	self assert: label text equals: 'Name2'.
	self assert: label emphasis equals: TextEmphasis normal
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testRemoveRenderDoesNotClearCommentIconDiagramElement [

	| classModel classShape commentIcon |
	classModel := OPUMLClass new name: 'CommentTestClass'.
	classModel ownedComments add: (OPUMLComment new body: 'Test comment').
	classShape := OPUmlClassShape in: OPNoShape instance forModelElement: classModel.
	classShape renderIn: canvas.

	commentIcon := classShape instVarNamed: #commentIcon.
	self assert: commentIcon class equals: OPUmlCommentIcon.
	self assertCollection: classShape ownedElements includesAll: { commentIcon }.

	classShape removeRender.
	self assert: (classShape instVarNamed: #commentIcon) identicalTo: commentIcon
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testSortOwnedElementsOrdersStaticBeforeNonStaticAndHandlesNilNames [

	| nilNameAttribute alphaAttribute staticZetaAttribute staticAlphaAttribute compartment sortedModels |
	nilNameAttribute := OPUMLProperty new.
	alphaAttribute := OPUMLProperty new name: 'alpha'.
	staticZetaAttribute := OPUMLProperty new
		                       name: 'zeta';
		                       isStatic: true;
		                       yourself.
	staticAlphaAttribute := OPUMLProperty new
		                        name: 'alpha';
		                        isStatic: true;
		                        yourself.
	compartment := OPUmlClassItemListCompartment new.
	{
		staticZetaAttribute.
		nilNameAttribute.
		alphaAttribute.
		staticAlphaAttribute } do: [ :eachAttribute |
			compartment ownedElements add: (OPUmlLabel new
					 modelElement: eachAttribute;
					 yourself) ].
	compartment sortOwnedElements.
	sortedModels := compartment ownedElements collect: #modelElement as: Array.
	self assert: sortedModels equals: {
			staticAlphaAttribute.
			staticZetaAttribute.
			nilNameAttribute.
			alphaAttribute }
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testStereotypeLabelNotDuplicatedOnReRender [

	| modelClass stereo initialStereoLabel stereoLabels |
	modelClass := OPUMLClass new name: 'Person'.
	stereo := OPUMLStereotype new.
	modelClass appliedStereotypes add: stereo.

	shape := OPUmlClassShape new.
	shape modelElement: modelClass.

	"1. Initial render"
	shape renderIn: canvas.
	initialStereoLabel := shape stereotypeLabel.
	self assert: initialStereoLabel class equals: OPUmlCompartmentableLabel.
	self assertCollection: shape ownedElements includesAll: { initialStereoLabel }.

	stereoLabels := shape ownedElements select: [ :each |
			                (each isKindOf: OPUmlCompartmentableLabel) and: [
				                each ownedElements anySatisfy: [ :child | child isKindOf: OPUmlAppliedStereotypesLabel ] ] ].
	self assert: stereoLabels size equals: 1.

	"2. Simulate closing the diagram editor"
	shape removeRender.

	"3. Simulate reopening the diagram editor"
	canvas := RSCanvas new.
	shape renderIn: canvas.

	self assert: shape stereotypeLabel identicalTo: initialStereoLabel.

	stereoLabels := shape ownedElements select: [ :each |
			                (each isKindOf: OPUmlCompartmentableLabel) and: [
				                each ownedElements anySatisfy: [ :child | child isKindOf: OPUmlAppliedStereotypesLabel ] ] ].
	self assert: stereoLabels size equals: 1.
	self assert: stereoLabels anyOne identicalTo: initialStereoLabel
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testStonInstVarNameForAndCompartmentSizing [

	| outerCompartment innerCompartment |
	self assert: (shape stonInstVarNameFor: #attributes) equals: #attributesCompartment.
	self assert: (shape stonInstVarNameFor: #operations) equals: #operationsCompartment.
	self assert: (shape stonInstVarNameFor: #bounds) equals: #bounds.
	self assert: OPUmlCompartmentableShape new minExtent equals: 20 @ 10.

	outerCompartment := OPUmlCompartment new.
	innerCompartment := OPUmlCompartment in: outerCompartment.
	self assert: (outerCompartment extentToFit: innerCompartment) equals: innerCompartment extentToFitContents
]

{ #category : 'tests' }
OPUmlClassShapeTest >> testUpdateCommentIconAndUpdateStereotypeBranches [

	| classModel stereotype commentIcon |
	classModel := OPUMLClass new name: 'Person'.
	classModel ownedComments add: (OPUMLComment new body: 'Has comment').
	stereotype := OPUMLStereotype new.
	classModel appliedStereotypes add: stereotype.

	shape modelElement: classModel.
	shape updateCommentIcon.
	commentIcon := shape instVarNamed: #commentIcon.
	self assert: commentIcon class equals: OPUmlCommentIcon.
	self deny: commentIcon isRendered description: 'Comment icon must not be rendered while owning classifier shape is unrendered'.

	shape renderIn: canvas.
	self assert: commentIcon isRendered description: 'Comment icon must be rendered after owning classifier shape renders'.
	shape updateCommentIcon.
	self assert: (shape instVarNamed: #commentIcon) identicalTo: commentIcon.

	classModel ownedComments removeAll.
	shape updateCommentIcon.
	self assert: (shape instVarNamed: #commentIcon) identicalTo: nil.

	self assert: shape stereotypeLabel class equals: OPUmlCompartmentableLabel.
	classModel appliedStereotypes removeAll.
	shape updateStereotype.
	self assert: shape stereotypeLabel identicalTo: nil
]
