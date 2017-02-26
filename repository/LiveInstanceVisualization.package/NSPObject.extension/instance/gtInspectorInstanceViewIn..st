*LiveInstanceVisualization-Inspector-Extensions
gtInspectorInstanceViewIn: composite
	<gtInspectorPresentationOrder: 80>
	| el |
	composite roassal2
		title: 'Instance View';
		initializeView: [ | v |
			v := RTView new.
			el := LIVLiveInstanceVisualization new shapeFor: self.
			el renderIn: v.
			LIVInteractiveViewContext setOnView: v.
			v @ RTDraggableView.
			v ]