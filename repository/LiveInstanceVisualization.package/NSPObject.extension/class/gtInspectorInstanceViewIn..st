*LiveInstanceVisualization
gtInspectorInstanceViewIn: composite
	<gtInspectorPresentationOrder: 80>
	| el |
	composite roassal2
		title: '[LIV] Class View';
		initializeView: [ | v |
			v := RTView new.
			el := LIVNSPClassVisualization new shapeFor: self.
			el renderIn: v.
			LIVInteractiveViewContext setOnView: v.
			v @ RTDraggableView.
			v ]