Class {
	#name : #LIVInternalCallGraphVisualization,
	#superclass : #Object,
	#category : 'LiveInstanceVisualization-Inspector-Extensions'
}

{ #category : #'as yet unclassified' }
LIVInternalCallGraphVisualization class >> nautilusClassesMenu: aBuilder [
	<contextMenu>
	<nautilusGlobalClassMenu>
	| target |
	target := aBuilder model.
	target selectedClass ifNil: [ ^ target ].
	(aBuilder item: #'Inspect')
		action: [ target selectedClass  inspect ];
		order: -99;
		withSeparatorAfter.
]

{ #category : #'as yet unclassified' }
LIVInternalCallGraphVisualization >> addMenuFor: aFigure [
	| menu |
	menu := PluggableMenuSpec new model: aFigure.
	menu
		add: 'Browse'
		action: (MessageSend receiver: aFigure model selector: #browse).
	aFigure when: TRMouseRightClick do: [ :event | menu asMenuMorph popUpInWorld ]
]

{ #category : #'as yet unclassified' }
LIVInternalCallGraphVisualization >> view: aView class: aClassDescription [
	| b els |
	b := RTMondrian new.
	b view: aView.
	b shape text
		color: Color black;
		text: #selector.
	els := b nodes: aClassDescription methods.
	els do: [ :each | self addMenuFor: each ].
	b shape horizontalBezierLine color: Color blue.
	b shape arrowedBezier
		head: RTEmptyArrowHead new;
		color: Color blue.
	b edges
		connectFromAll: [ :s | (aClassDescription thoroughWhichSelectorsReferTo: s selector) collect: [ :each | aClassDescription>>each ] ].
	b layout horizontalDominanceTree
		verticalGap: 40;
		horizontalGap: 70.
	b build
]
