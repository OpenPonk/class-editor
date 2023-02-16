Class {
	#name : #OPUmlEdgeMarkers,
	#superclass : #Object,
	#classInstVars : [
		'current'
	],
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #meta }
OPUmlEdgeMarkers class >> compileDelegatorFor: aMethod [
	(self class selectors includes: aMethod selector)
		ifTrue: [ ^ self ].
	self class
		compile:
			('{1}
	^ self current {1}' format: {aMethod sourceCode lines first})
		classified: 'markers'
]

{ #category : #accessing }
OPUmlEdgeMarkers class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #markers }
OPUmlEdgeMarkers class >> emptyArrow [
	^ self current emptyArrow
]

{ #category : #markers }
OPUmlEdgeMarkers class >> emptyDiamond [
	^ self current emptyDiamond
]

{ #category : #markers }
OPUmlEdgeMarkers class >> emptyDiamondWith: aString [
	^ self current emptyDiamondWith: aString
]

{ #category : #markers }
OPUmlEdgeMarkers class >> filledArrow [
	^ self current filledArrow
]

{ #category : #markers }
OPUmlEdgeMarkers class >> filledDiamond [
	^ self current filledDiamond
]

{ #category : #markers }
OPUmlEdgeMarkers class >> filledDiamondWith: aString [
	^ self current filledDiamondWith: aString
]

{ #category : #markers }
OPUmlEdgeMarkers class >> none [
	^ self current none
]

{ #category : #markers }
OPUmlEdgeMarkers class >> simpleArrow [
	^ self current simpleArrow
]

{ #category : #meta }
OPUmlEdgeMarkers class >> updateShortcutMethods [
	<script>
	(self methodsInProtocol: 'markers') do: [ :each | self compileDelegatorFor: each ]
]

{ #category : #markers }
OPUmlEdgeMarkers >> emptyArrow [

	^ self filledArrow asEmptyMarker
]

{ #category : #markers }
OPUmlEdgeMarkers >> emptyDiamond [

	^ self filledDiamond asEmptyMarker
]

{ #category : #markers }
OPUmlEdgeMarkers >> emptyDiamondWith: aString [
	^ OPRTTextDiamondMarker emptyWith: aString
]

{ #category : #markers }
OPUmlEdgeMarkers >> filledArrow [

	^ RSShapeFactory polygonWithPoints: { 
			  (0 @ 0).
			  (-5 @ 8).
			  (0 @ 8).
			  (-5 @ 16).
			  (5 @ 16).
			  (0 @ 8).
			  (5 @ 8) }
]

{ #category : #markers }
OPUmlEdgeMarkers >> filledDiamond [

	^ RSPolygon new
		  points: { 
				  (0 @ 20).
				  (7 @ 10).
				  (0 @ 0).
				  (-7 @ 10) };
		  yourself
]

{ #category : #markers }
OPUmlEdgeMarkers >> filledDiamondWith: aString [

	^ RSBorderColoringComposite new
		  shapes: { 
				  self filledDiamond.
				  (RSLabel new
					   text: aString;
					   color: Color white;
					   fontSize: 9;
					   translateBy: -0.5 @ 10;
					   yourself) };
		  yourself
]

{ #category : #markers }
OPUmlEdgeMarkers >> none [
	^ nil
]

{ #category : #markers }
OPUmlEdgeMarkers >> simpleArrow [

	| shape marker |
	shape := RSPolygon new points: { 
			         (5 @ 10).
			         (0 @ 5).
			         (-5 @ 10).
			         (0 @ 0) }.
	marker := shape asMarker.
	marker offset: shape height.
	^ marker
]
