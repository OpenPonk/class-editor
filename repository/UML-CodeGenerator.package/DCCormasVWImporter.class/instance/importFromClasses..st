as yet unclassified
importFromClasses: aCollection
	| model |
	model := DCCodeToUmlGenerator new importFromClasses: aCollection.
	model allModelClasses do: [ :each | self mergeClass: each ].
	^ model