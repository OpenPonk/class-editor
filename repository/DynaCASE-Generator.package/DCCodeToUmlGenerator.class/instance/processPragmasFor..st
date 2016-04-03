as yet unclassified
processPragmasFor: aModel
	aModel allClasses do: [ :each | self processPragmasForClass: each ].
	self haltOnce