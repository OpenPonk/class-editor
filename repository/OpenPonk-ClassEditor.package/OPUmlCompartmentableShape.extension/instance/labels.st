*OpenPonk-ClassEditor-Accessing
labels
	| priorities |
	priorities := {(OPUmlKeywordLabel -> 1).
	(OPUmlNameLabel -> 2).
	(OPUmlLabel -> 3)} asDictionary.
	^ ((self ownedElements select: [ :each | each isKindOf: OPUmlLabel ])
		asSortedCollection: [ :a :b | (priorities at: a class) < (priorities at: b class) ])
		asGroup