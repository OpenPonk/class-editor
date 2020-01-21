Class {
	#name : #LIVExpandableCallGraphVisualization,
	#superclass : #Object,
	#instVars : [
		'mondrian'
	],
	#category : 'LiveInstanceVisualization-Inspector-Extensions'
}

{ #category : #'as yet unclassified' }
LIVExpandableCallGraphVisualization >> addMenuFor: aFigure [
	| menu |
	menu := PluggableMenuSpec new model: aFigure.
	menu add: 'Browse' action: (MessageSend receiver: aFigure model selector: #browse).
	menu
		add: 'Senders'
		target: self
		selector: #addSendersFor:
		argumentList: {aFigure}.
	aFigure when: TRMouseRightClick do: [ :event | menu asMenuMorph popUpInWorld ]
]

{ #category : #'as yet unclassified' }
LIVExpandableCallGraphVisualization >> addSendersFor: aFigure [
	| senders b els |
	senders := aFigure model senders
		reject: [ :meth | mondrian view elements anySatisfy: [ :each | each model = meth ] ].
	b := mondrian.
	b shape text
		color: Color black;
		text: [ :each | each method name ].
	els := b nodes: senders.
	els do: [ :each | self addMenuFor: each ].
	b shape horizontalBezierLine color: Color blue.
	b shape arrowedBezier
		head: RTEmptyArrowHead new;
		color: Color blue.
	b edges connectFromAll: [ :s | senders ] to: [ :s | aFigure model ].
	b layout horizontalDominanceTree
		verticalGap: 40;
		horizontalGap: 70.
	b build
]

{ #category : #'as yet unclassified' }
LIVExpandableCallGraphVisualization >> initialize [
	super initialize.
	mondrian := RTMondrian new
]

{ #category : #'as yet unclassified' }
LIVExpandableCallGraphVisualization >> view: aView class: aClassDescription [
	| b els |
	b := mondrian.
	b view: aView.
	b shape text
		color: Color black;
		text: #selector";
		if: [ :m | m senders isEmpty ] color: Color gray".
	els := b nodes: aClassDescription methods.
	els do: [ :each | self addMenuFor: each ].
	b shape horizontalBezierLine color: Color blue.
	b shape arrowedBezier
		head: RTEmptyArrowHead new;
		color: Color blue.
	b edges
		connectFromAll: [ :s | 
			(aClassDescription thoroughWhichSelectorsReferTo: s selector)
				collect: [ :each | aClassDescription >> each ] ].
	b layout horizontalDominanceTree
		verticalGap: 40;
		horizontalGap: 70.
	b build
]
