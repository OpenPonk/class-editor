Extension { #name : 'ClassDescription' }

{ #category : '*LiveInstanceVisualization-Inspector-Extensions' }
ClassDescription >> gtInspectorExpandableCallGraphIn: composite [
	<gtInspectorPresentationOrder: 80>
	| el |
	composite roassal2
		title: '[LIVE] Calls graph';
		initializeView: [ | v |
			v := RTView new.
			el := LIVExpandableCallGraphVisualization new view: v class: self.
			v @ RTDraggableView.
			v ]
]

{ #category : '*LiveInstanceVisualization-Inspector-Extensions' }
ClassDescription >> gtInspectorInstanceViewIn: composite [
	<gtInspectorPresentationOrder: 80>
	| el |
	composite roassal2
		title: '[LIV] Calls graph';
		initializeView: [ | v |
			v := RTView new.
			el := LIVInternalCallGraphVisualization new view: v class: self.
			v @ RTDraggableView.
			v ]
]
