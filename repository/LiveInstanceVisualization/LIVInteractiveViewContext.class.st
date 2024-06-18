Class {
	#name : 'LIVInteractiveViewContext',
	#superclass : 'RTAbstractViewContext',
	#category : 'LiveInstanceVisualization',
	#package : 'LiveInstanceVisualization'
}

{ #category : 'as yet unclassified' }
LIVInteractiveViewContext >> interactionsToBeRegistered [
	^ Array
		with: LIVSelectableModelElementContextInteraction
		with: RTResizeableViewContextInteraction
		with: RTZoomableViewContextInteraction
]
