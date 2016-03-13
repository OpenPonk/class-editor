as yet unclassified
processPragmasFor: aModel
	aModel allModelClasses do: [ :each | self processPragmasForClass: each ].
	self haltOnce