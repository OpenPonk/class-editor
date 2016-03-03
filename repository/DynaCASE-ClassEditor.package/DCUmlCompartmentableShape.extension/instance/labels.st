*DynaCASE-ClassEditor-Accessing
labels
	| priorities |
	priorities := {(DCUmlKeywordLabel -> 1).
	(DCUmlNameLabel -> 2).
	(DCUmlLabel -> 3)} asDictionary.
	^ ((self ownedElements select: [ :each | each isKindOf: DCUmlLabel ])
		asSortedCollection: [ :a :b | (priorities at: a class) < (priorities at: b class) ])
		asGroup