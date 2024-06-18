Class {
	#name : 'LIVInstanceModelDiff',
	#superclass : 'Object',
	#category : 'LiveInstanceVisualization-Diff',
	#package : 'LiveInstanceVisualization',
	#tag : 'Diff'
}

{ #category : 'as yet unclassified' }
LIVInstanceModelDiff >> diffBetween: anOldModel and: aNewModel [
	| oldHashes newHashes removed added modified propertyDiff |
	oldHashes := anOldModel elements collect: #instanceHash.
	newHashes := aNewModel elements collect: #instanceHash.
	removed := oldHashes \ newHashes.
	added := newHashes \ oldHashes.
	modified := oldHashes intersection: newHashes.
	propertyDiff := Dictionary new.
	modified
		do: [ :each | 
			propertyDiff
				at: each
				put:
					(self
						propertyDiffBetween: (anOldModel elements detect: [ :e | e instanceHash = each ])
						and: (aNewModel elements detect: [ :e | e instanceHash = each ])) ].
	^ Dictionary
		with: #added -> (aNewModel elements select: [ :each | added includes: each instanceHash ])
		with: #modified -> propertyDiff
		with: #removed -> (anOldModel elements select: [ :each | removed includes: each instanceHash ])
]

{ #category : 'as yet unclassified' }
LIVInstanceModelDiff >> propertyDiffBetween: anOldInstance and: aNewInstance [
	| added removed same modified |
	added := aNewInstance slots keys \ anOldInstance slots keys.
	removed := anOldInstance slots keys \ aNewInstance slots keys.
	modified := Set new.
	same := aNewInstance slots keys intersection: anOldInstance slots keys.
	same
		do: [ :key | 
			| oldValue newValue |
			oldValue := anOldInstance slots at: key.
			newValue := aNewInstance slots at: key.
			(oldValue = newValue
				or: [ ((oldValue isKindOf: LIVInstanceSpecification)
						and: [ newValue isKindOf: LIVInstanceSpecification ])
						and: [ oldValue instanceHash = newValue instanceHash ] ])
				ifFalse: [ modified add: key ] ].
	^ Dictionary
		with: #added -> (aNewInstance slots associationsSelect: [ :pair | added includes: pair key ])
		with:
			#removed
				-> (anOldInstance slots associationsSelect: [ :pair | removed includes: pair key ])
		with:
			#modified
				-> (aNewInstance slots associationsSelect: [ :pair | modified includes: pair key ])
]
