ui hooks
figuresFor: aCollection
	^ (aCollection
		collect: [ :model | 
			diagramController controllers
				detect: [ :each | each model = model ]
				ifFound: #figure
				ifNone: [ nil ] ]) reject: #isNil