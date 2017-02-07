as yet unclassified
defaultCollectionTypes
	^ #(Collection OrderedCollection Set Dictionary Array)
		collect: [ :each | FAMIXClass new name: each ]