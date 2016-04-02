as yet unclassified
importFromPackageNamed: aString
	| model |
	model := DCCodeToUmlGenerator new importFromPackageNamed: aString.
	model allModelClasses do: [ :each | self mergeClass: each ].
	^ model