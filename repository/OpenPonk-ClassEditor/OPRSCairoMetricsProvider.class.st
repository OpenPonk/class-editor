Class {
	#name : 'OPRSCairoMetricsProvider',
	#superclass : 'RSCairoMetricsProvider',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'hooks' }
OPRSCairoMetricsProvider >> extentsOf: aRSLabel [
	"This entire class exists to overcome 
	https://github.com/pharo-graphics/Roassal/issues/64"

	| copy |
	self flag: 'https://github.com/pharo-graphics/Roassal/issues/64'.
	aRSLabel isNormal ifTrue: [ ^ super extentsOf: aRSLabel ].
	copy := RSLabel new
		        font: aRSLabel font;
		        text: aRSLabel text , '.';
		        yourself.
	^ copy textExtents
]
