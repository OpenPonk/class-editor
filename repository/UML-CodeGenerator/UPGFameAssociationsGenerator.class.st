Class {
	#name : #UPGFameAssociationsGenerator,
	#superclass : #UPGSimpleAccessorsGenerator,
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #'generator - templates' }
UPGFameAssociationsGenerator >> getter: anEnd [
	^ self eagerGetter: anEnd
	"Lazy getter is not supported by FAME, eager will always be used"
]

{ #category : #'generator - templates' }
UPGFameAssociationsGenerator >> setter: anEnd [
	^ self
		replace: (self templateNamed: #setter:)
		with:
			{#aValue -> (self paramNameForEnd: anEnd).
			#setter -> anEnd name}
]
