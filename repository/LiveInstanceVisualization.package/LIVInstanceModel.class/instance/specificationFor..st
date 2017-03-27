as yet unclassified
specificationFor: anObject
	^ elements detect: [ :each | each instanceHash = anObject hash ]