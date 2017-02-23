as yet unclassified
removeAutomaticCormasAssociation
	| sourceClass |
	sourceClass := self diagramController model allClasses
		detect:
			[ :each | each stereotypes isNotEmpty and: [ each stereotypes first name = 'CormasModel' ] ]
		ifFound: #yourself
		ifNone: [ ^ self ].
	(self model incomingAssociations
		select:
			[ :each | each source = sourceClass and: [ each targetEnd name = ('the' , self model name , 's') ] ])
		do: [ :each | self diagramController removeFromModel: each ]