tests
testRoundtrip
	| originalModel loadedModel serialization |
	originalModel := self newModel.
	serialization := serializer serializeModel: originalModel.
	loadedModel := serializer materializeModelFrom: serialization.
	self
		assert: (originalModel packagedElements collect: #name)
		equals: (loadedModel packagedElements collect: #name)