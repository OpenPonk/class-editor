"
I am a specialized layout manager for UML Class Diagrams. I expose specific graph layout algorithms (like tree, grid, circle, and Sugiyama) and apply them to the current UML diagram canvas.
"
Class {
	#name : 'OPUmlLayouter',
	#superclass : 'OPHierarchicalNodesAndEdgesLayouter',
	#category : 'OpenPonk-ClassEditor-Plugin',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPUmlLayouter >> allEdges [
	"Answers all relationship shapes rendered in the diagram."

	| relationshipControllers |
	relationshipControllers := diagramController controllers select: [ :eachController |
		eachController isKindOf: OPDirectionalRelationshipController ].
	^ (relationshipControllers collect: #roassalShape thenSelect: #isNotNil) asGroup
]

{ #category : 'accessing' }
OPUmlLayouter >> allNodes [
	"Answers all rendered node shapes in diagram."

	^ self allRenderedNodeShapes
]

{ #category : 'accessing' }
OPUmlLayouter >> allRenderedNodeShapes [
	"Answers all roassal shapes for rendered node controllers in the diagram."

	^ (diagramController controllers
		select: [ :eachController |
			(eachController respondsTo: #diagramElement) and: [
				(eachController diagramElement isKindOf: OPBoundNode) and: [
					eachController roassalShape isNotNil and: [
						eachController diagramElement isRendered and: [
							eachController diagramElement isPositionableByUser or: [
								eachController diagramElement isResizableByUser ] ] ] ] ] ]
		thenCollect: #roassalShape) asGroup
]

{ #category : 'userinterface' }
OPUmlLayouter >> applyLayout: aThreeArgBlock [
	| allTargetNodes snapshot activeContainers topLevelBoxes generalizations extensions linkRelationships invertedExtensionShapes filteredHierarchy filteredLinks commands |
	allTargetNodes := self allRenderedNodeShapes.
	snapshot := OPDiagramGeometrySnapshot onNodes: allTargetNodes.

	activeContainers := self containerElementsBottomUp.
	self layoutContainersHierarchically: activeContainers.

	topLevelBoxes := self topLevelNodeShapes.

	generalizations := (diagramController controllers
		select: [ :eachController |
			(eachController respondsTo: #model) and: [
				eachController model isNotNil and: [
					eachController model oclIsKindOf: #Generalization ] ] ]
		thenCollect: #roassalShape) asGroup.

	extensions := (diagramController controllers
		select: [ :eachController |
			(eachController respondsTo: #model) and: [
				eachController model isNotNil and: [
					eachController model oclIsKindOf: #Extension ] ] ]
		thenCollect: #roassalShape) asGroup.

	linkRelationships := (diagramController controllers
		select: [ :eachController |
			(eachController respondsTo: #model) and: [
				eachController model isNotNil and: [
					(eachController model oclIsKindOf: #Relationship) and: [
						(eachController model oclIsKindOf: #Extension) not ] ] ] ]
		thenCollect: #roassalShape) asGroup.

	invertedExtensionShapes := extensions collect: [ :eachEdge |
		| from to |
		from := eachEdge from.
		to := eachEdge to.
		eachEdge copy
			from: to;
			to: from;
			yourself ].

	filteredHierarchy := ((generalizations , invertedExtensionShapes) select: [ :eachEdge |
		(topLevelBoxes includes: eachEdge from) and: [ topLevelBoxes includes: eachEdge to ] ]) asGroup.
	filteredLinks := (linkRelationships select: [ :eachEdge |
		(topLevelBoxes includes: eachEdge from) and: [ topLevelBoxes includes: eachEdge to ] ]) asGroup.

	aThreeArgBlock
		value: topLevelBoxes
		value: filteredHierarchy
		value: filteredLinks.

	self unsubscribeContainers: activeContainers.

	commands := snapshot deltaCommands.
	self executeLayoutCommands: commands.
	self updateCanvas
]

{ #category : 'layouts' }
OPUmlLayouter >> circleLayout [
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RSWeightedCircleLayout new
				scaleBy: 20;
				on: boxes ]
]

{ #category : 'layouts' }
OPUmlLayouter >> defaultLayout [
	self dominanceTreeLayout
]

{ #category : 'layouts' }
OPUmlLayouter >> dominanceTreeLayout [
	"Applies a dominance tree layout to boxes and relationships, falling back silently to grid layout on cycles."

	self applyLayout: [ :boxes :hierarchy :links |
		(OPLayoutLoopDetector haveLoopsBoxes: boxes links: hierarchy , links)
			ifTrue: [ ^ self gridLayout ].
		RSDominanceTreeLayout new
			verticallyReverse;
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links ]
]

{ #category : 'layouts' }
OPUmlLayouter >> gridLayout [
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RSGridLayout new
				gapSize: 140;
				on: boxes ]
]

{ #category : 'layouts' }
OPUmlLayouter >> layoutInnerContentOf: aContainerElement shapes: directShapes edges: directEdges [
	"Positions direct children of an inner package using horizontal dominance tree layout."
	directShapes size = 1
		ifTrue: [ directShapes first translateTo: 0 @ 20 ]
		ifFalse: [
			RSHorizontalDominanceTreeLayout new
				horizontalGap: 50;
				verticalGap: 40;
				on: directShapes edges: directEdges.
			directShapes translateBy: (0 @ 20) - directShapes encompassingRectangle center ]
]

{ #category : 'layouts' }
OPUmlLayouter >> sugiyamaLayout [
	"Applies a Sugiyama layout to boxes and relationships, falling back silently to grid layout on cycles."

	self applyLayout: [ :boxes :hierarchy :links |
		| centerY |
		(OPLayoutLoopDetector haveLoopsBoxes: boxes links: hierarchy , links)
			ifTrue: [ ^ self gridLayout ].
		RSSugiyamaLayout new
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links.
		centerY := (RSGroup withAll: boxes) encompassingRectangle center y.
		boxes do: [ :each |
			each translateBy: 0 @ 2 * (centerY - each position y) ] ]
]

{ #category : 'layouts' }
OPUmlLayouter >> treeLayout [
	"Applies a tree layout to boxes and relationships, falling back silently to grid layout on cycles."

	self applyLayout: [ :boxes :hierarchy :links |
		| centerY |
		(OPLayoutLoopDetector haveLoopsBoxes: boxes links: links)
			ifTrue: [ ^ self gridLayout ].
		RSTreeLayout new
			verticalGap: 100;
			horizontalGap: 100;
			on: boxes edges: hierarchy , links.
		centerY := (RSGroup withAll: boxes) encompassingRectangle center y.
		boxes do: [ :each |
			each translateBy: 0 @ 2 * (centerY - each position y) ] ]
]
