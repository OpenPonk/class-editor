Class {
	#name : #LIVInteractiveViewContext,
	#superclass : #RTAbstractViewContext,
	#category : 'LiveInstanceVisualization'
}

{ #category : #'as yet unclassified' }
LIVInteractiveViewContext >> interactionsToBeRegistered [
	^ Array
		with: LIVSelectableModelElementContextInteraction
		with: RTResizeableViewContextInteraction
		with: RTZoomableViewContextInteraction
]
