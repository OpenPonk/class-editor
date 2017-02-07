public-exporting
export: aModel
	stream := String new writeStream.
	(aModel isKindOf: MooseModel)
		ifTrue: [ self visitModel: aModel ]
		ifFalse: [ aModel accept: self ].
	^ stream contents