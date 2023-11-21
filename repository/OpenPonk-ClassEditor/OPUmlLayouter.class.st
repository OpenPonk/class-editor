"
I manage layouts available for UML Editor and apply them.
"
Class {
	#name : #OPUmlLayouter,
	#superclass : #OPLayouter,
	#category : #'OpenPonk-ClassEditor-Plugin'
}

{ #category : #userinterface }
OPUmlLayouter >> applyLayout: aThreeArgBlock [

	| packageableElements packageableRelationships subtypeRelationships linkRelationships boxes renderedModels generalizations extensions invertedExtensionShapes |
	renderedModels := diagramController controllers
		                  select: #isRendered
		                  thenCollect: #model.
	packageableElements := renderedModels select: [ :each |
		                       each oclIsKindOf: #PackageableElement ].
	packageableRelationships := packageableElements select: [ :each |
		                            each oclIsKindOf: #Relationship ].
	generalizations := renderedModels select: [ :each |
		                   each oclIsKindOf: #Generalization ].
	extensions := packageableRelationships select: [ :each |
		              each oclIsKindOf: #Extension ].

	boxes := packageableElements \ packageableRelationships.
	subtypeRelationships := generalizations , extensions.
	linkRelationships := packageableRelationships \ extensions.
	invertedExtensionShapes := (self roassalShapesFor: extensions)
		                           collect: [ :each |
			                           | from to |
			                           from := each from.
			                           to := each to.
			                           each copy
				                           from: to;
				                           to: from;
				                           yourself ].
	aThreeArgBlock
		value: (self roassalShapesFor: boxes)
		value:
		(self roassalShapesFor: generalizations) , invertedExtensionShapes
		value: (self roassalShapesFor: linkRelationships).
	self updateCanvas
]

{ #category : #layouts }
OPUmlLayouter >> circleLayout [
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RSWeightedCircleLayout new
				scaleBy: 20;
				on: boxes ]
]

{ #category : #layouts }
OPUmlLayouter >> defaultLayout [
	self dominanceTreeLayout
]

{ #category : #layouts }
OPUmlLayouter >> dominanceTreeLayout [

	self applyLayout: [ :boxes :hierarchy :links |
		RSDominanceTreeLayout new
			verticallyReverse;
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links ]
]

{ #category : #layouts }
OPUmlLayouter >> gridLayout [
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RSGridLayout new
				gapSize: 140;
				on: boxes ]
]

{ #category : #layouts }
OPUmlLayouter >> sugiyamaLayout [

	self applyLayout: [ :boxes :hierarchy :links | 
		| centerY |
		RSSugiyamaLayout new
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links.
		centerY := (RSGroup withAll: boxes) encompassingRectangle center y.
		boxes do: [ :each | 
			each translateBy: 0 @ 2 * (centerY - each position y) ] ]
]

{ #category : #layouts }
OPUmlLayouter >> treeLayout [

	self applyLayout: [ :boxes :hierarchy :links |
		| centerY |
		RSTreeLayout new
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links.
		centerY := (RSGroup withAll: boxes) encompassingRectangle center y.
		boxes do: [ :each |
			each translateBy: 0 @ 2 * (centerY - each position y) ] ]
]
