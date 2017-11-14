ui hooks
figuresFor: aCollection
	^ aCollection collect: [ :each | diagramController figureForModel: each ]