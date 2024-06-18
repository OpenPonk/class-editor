Class {
	#name : 'LIVInstanceDiffColorer',
	#superclass : 'Object',
	#category : 'LiveInstanceVisualization-Diff',
	#package : 'LiveInstanceVisualization',
	#tag : 'Diff'
}

{ #category : 'as yet unclassified' }
LIVInstanceDiffColorer >> colorAdditions: aCollection in: aView [
	| els |
	els := (self diagramElementsIn: aView)
		select: [ :each | aCollection includes: each model modelElement ].
	els
		do: [ :el | 
			| fig |
			fig := el model.
			fig sharedStyle fillColor: Color green muchLighter.
			fig update.
			fig sourceEdges , fig targetEdges
				do: [ :each | 
					each ownedElements
						do: [ :lbl | 
							lbl sharedStyle fontColor: Color green muchDarker.
							lbl update ].
					each localStyle strokeColor: Color green muchDarker.
					each update ] ]
]

{ #category : 'as yet unclassified' }
LIVInstanceDiffColorer >> colorAll: aDictionary in: aView [
	self colorAdditions: (aDictionary at: #added) in: aView.
	self colorModifications: (aDictionary at: #modified) in: aView.
	self colorRemovals: (aDictionary at: #removed) in: aView
]

{ #category : 'as yet unclassified' }
LIVInstanceDiffColorer >> colorModifications: aDictionary in: aView [
	aDictionary
		keysAndValuesDo: [ :hash :dict | 
			| el fig subFigs |
			el := aView elements
				detect: [ :each | 
					(each model modelElement isKindOf: LIVInstanceSpecification)
						and: [ each model modelElement instanceHash = hash ] ].
			fig := el model.
			subFigs := fig deepCollect: #ownedElements.
			(dict at: #added)
				keysAndValuesDo: [ :key :value | 
					subFigs
						detect: [ :each | each modelElement = key ]
						ifFound: [ :each | 
							each sharedStyle fontColor: Color green muchDarker.
							each update ] ].
			(dict at: #modified)
				keysAndValuesDo: [ :key :value | 
					subFigs
						detect: [ :each | each modelElement = key ]
						ifFound: [ :each | 
							each sharedStyle fontColor: Color blue.
							each update ].
					aView edges
						detect: [ :each | 
							(each model isKindOf: OPUmlEdge)
								and: [ each model modelElement = (fig modelElement -> key) ] ]
						ifFound: [ :each | 
							each model ownedElements
								detect: [ :lbl | lbl modelElement = key ]
								ifFound: [ :lbl | 
									lbl sharedStyle fontColor: Color blue.
									lbl update ].
							each model localStyle strokeColor: Color blue.
							each model update ] ] ]
]

{ #category : 'as yet unclassified' }
LIVInstanceDiffColorer >> colorRemovals: aCollection in: aView [
	| els |
	els := (self diagramElementsIn: aView)
		select: [ :each | aCollection includes: each model modelElement ].
	els
		do: [ :el | 
			| fig |
			fig := el model.
			fig sharedStyle fillColor: Color red muchLighter.
			fig update ]
]

{ #category : 'as yet unclassified' }
LIVInstanceDiffColorer >> diagramElementsIn: aView [
	^ aView elements select: [ :each | each model isKindOf: OPUmlDiagramElement ]
]
