adding
removeLinkFrom: sourceObject at: aSlot
	| object removed |
	object := self specificationFor: sourceObject.
	removed := object slots at: aSlot.
"	(elements noneSatisfy: [ :each | (each = object) not and: [ each slots associations includes: removed ] ])
		ifTrue: [ elements removeAllSuchThat: [ :each | each instanceHash = removed instanceHash ] ]."
	object slots at: aSlot put: nil