as yet unclassified
instanceOn: anObject
	| model |
	model := self newModel.
	model classifier: anObject class.
	model instanceHash: anObject hash.
	name ifNotNil: [ model name: (name value: anObject) ].
	slots
		keysAndValuesDo: [ :key :value | model slots at: key put: (value ifNotNil: [ value value: anObject ]) ].
	^ model