Class {
	#name : #OPUmlLabelTest,
	#superclass : #OPDiagramElementTestCase,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #tests }
OPUmlLabelTest >> elementClass [
	^ OPUmlLabel
]

{ #category : #tests }
OPUmlLabelTest >> testBlockNameUpdate [
	element modelElement: 'hello'.
	element text: #yourself.
	rt := element roassalShape.
	self assert: (rt shape textFor: rt) equals: 'hello'.
	element modelElement: 'world'.
	self assert: (rt shape textFor: rt) equals: 'world'
]

{ #category : #tests }
OPUmlLabelTest >> testRoassalShape [

	| roassalShape |
	element text: 'some text'.
	element renderIn: RSCanvas new.
	roassalShape := element roassalShape.
	self assert: roassalShape class equals: RSLabel.
	self assert: roassalShape text equals: 'some text'
]

{ #category : #tests }
OPUmlLabelTest >> testRoassalShapeEmphasis [
	element text: 'some text'.
	element localStyle: OPDIOpenPonkStyle new.
	rt := element roassalShape.
	self assertCollection: (rt shape emphasisFor: rt) hasSameElements: #().

	element localStyle fontBold: true.
	self assertCollection: (rt shape emphasisFor: rt) hasSameElements: {TextEmphasis bold}.

	element localStyle fontUnderline: true.
	self
		assertCollection: (rt shape emphasisFor: rt)
		hasSameElements:
			{TextEmphasis bold.
			TextEmphasis underlined}.

	element localStyle fontItalic: true.
	self
		assertCollection: (rt shape emphasisFor: rt)
		hasSameElements:
			{TextEmphasis bold.
			TextEmphasis underlined.
			TextEmphasis italic}
]

{ #category : #tests }
OPUmlLabelTest >> testRoassalShapeEmphasisUpdate [
	element text: 'some text'.
	element
		emphasis: [ :model :localStyle | 
			localStyle fontBold: model first.
			localStyle fontItalic: model second ].
	element localStyle: OPDIOpenPonkStyle new.
	element modelElement: #(true true).
	rt := element roassalShape.
	self
		assertCollection: (rt shape emphasisFor: rt)
		hasSameElements:
			{TextEmphasis bold.
			TextEmphasis italic}.
	element modelElement: #(true false).
	self assertCollection: (rt shape emphasisFor: rt) hasSameElements: {TextEmphasis bold}
]

{ #category : #tests }
OPUmlLabelTest >> testRoassalShapeNameUpdate [
	element text: 'some text'.
	rt := element roassalShape.
	self assert: (rt shape textFor: rt) equals: 'some text'.
	element text: 'new text'.
	self assert: (rt shape textFor: rt) equals: 'new text'
]
