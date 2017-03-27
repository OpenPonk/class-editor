inspector - extensions
gtInspectorModelViewIn: composite
	<gtInspectorPresentationOrder: 80>
	composite roassal2
		title: '[LIV] Instance Model';
		initializeView: [ | v |
			v := RTView new.
			self renderIn: v.
			self showDiffIn: v.
			v @ RTDraggableView.
			v ]