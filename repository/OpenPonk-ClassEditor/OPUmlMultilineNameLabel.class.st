Class {
	#name : #OPUmlMultilineNameLabel,
	#superclass : #OPUmlNameLabel,
	#category : #'OpenPonk-ClassEditor-DiagramElements'
}

{ #category : #'Roassal2 - manipulation' }
OPUmlMultilineNameLabel >> createRoassalShape [
	^ OPRTStyledMultilineLabel new
		fontSize: #fontSize;
		color: #fontColor;
		text: #text;
		emphasis: #emphasis;
		elementOn: self
]
