as yet unclassified
descriptions
	| descriptions |
	self model ifNil: [ ^ #() ].
	descriptions := OrderedCollection new.
	self model appliedStereotypes
		do: [ :stereo | 
			| meta |
			meta := stereo umlMetaClass.
			meta ownedAttributes
				do: [ :attr | self addTo: descriptions attribute: attr of: stereo ] ].
	^ descriptions