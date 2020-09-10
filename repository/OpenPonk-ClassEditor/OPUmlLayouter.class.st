"
I manage layouts available for UML Editor and apply them.
"
Class {
	#name : #OPUmlLayouter,
	#superclass : #OPLayouter,
	#instVars : [
		'packagedElements'
	],
	#category : #'OpenPonk-ClassEditor-Plugin'
}

{ #category : #'ui hooks' }
OPUmlLayouter >> applyLayout: aThreeArgBlock [
	| classifiers classes packages hierarchy associations packageImports boxes links |
	classifiers := packagedElements
		select: [ :each | (each oclIsKindOf: #Class) | (each oclIsKindOf: #DataType) ].
	classes := classifiers select: [ :each | each oclIsKindOf: #Class ].
	packages := packagedElements select: [ :each | each oclIsKindOf: #Package ].
	hierarchy := (classifiers flatCollect: #generalizations)
		, (classes flatCollect: #extensions).
	associations := (packagedElements select: [ :each | each oclIsKindOf: #Association ])
		\ hierarchy.
	packageImports := packages flatCollect: #packageImports.
	boxes := classifiers , packages.
	links := associations , packageImports.
	aThreeArgBlock
		value: (self figuresFor: boxes)
		value: (self figuresFor: hierarchy)
		value: (self figuresFor: links).
	self updateView
]

{ #category : #'ui hooks' }
OPUmlLayouter >> circleLayout [
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RTWeightedCircleLayout new
				scaleBy: 20;
				on: boxes ]
]

{ #category : #'ui hooks' }
OPUmlLayouter >> defaultLayout [
	self dominanceTreeLayout
]

{ #category : #accessing }
OPUmlLayouter >> diagramController: aDiagramController [
	diagramController := aDiagramController.
	packagedElements := diagramController model packagedElements
]

{ #category : #'ui hooks' }
OPUmlLayouter >> dominanceTreeLayout [
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RTDominanceTreeLayout new
				verticallyReverse;
				verticalGap: 100;
				horizontalGap: 100;
				doNotAttachPoint;
				on: boxes edges: hierarchy , links ]
]

{ #category : #'ui hooks' }
OPUmlLayouter >> gridLayout [
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RTGridLayout new
				gapSize: 140;
				on: boxes ]
]

{ #category : #'ui hooks' }
OPUmlLayouter >> sugiyamaLayout [

	self applyLayout: [ :boxes :hierarchy :links | 
		| centerY |
		RTSugiyamaLayout new
			doNotAttachPoint;
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links.
		centerY := (RTGroup withAll: boxes) encompassingRectangle center y.
		boxes do: [ :each | 
			each translateBy: 0 @ 2 * (centerY - each position y) ] ]
]

{ #category : #'ui hooks' }
OPUmlLayouter >> treeLayout [

	self applyLayout: [ :boxes :hierarchy :links | 
		| centerY |
		RTTreeLayout new
			doNotAttachPoint;
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links.
		centerY := (RTGroup withAll: boxes) encompassingRectangle center y.
		boxes do: [ :each | 
			each translateBy: 0 @ 2 * (centerY - each position y) ] ]
]
