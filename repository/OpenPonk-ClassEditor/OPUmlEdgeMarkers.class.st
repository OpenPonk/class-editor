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

	^ RSShapeFactory polygonWithPoints: (Array
			   with: 0 @ 10
			   with: 7 @ 0
			   with: 0 @ -10
			   with: -7 @ 0)
]

{ #category : #markers }
OPUmlEdgeMarkers >> filledDiamondWith: aString [

	| group |
	group := RSGroup with: self filledDiamond with: (RSLabel new
			          text: aString;
			          color: Color white;
			          fontSize: 9;
			          yourself).
	^ group asShape
]

{ #category : #markers }
OPUmlEdgeMarkers >> none [
	^ nil
]

{ #category : #markers }
OPUmlEdgeMarkers >> simpleArrow [

	^ (RSShapeFactory polygonWithPoints: (Array
			    with: 5 @ 10
			    with: 0 @ 5
			    with: -5 @ 10
			    with: 0 @ 0)) yourself
]
