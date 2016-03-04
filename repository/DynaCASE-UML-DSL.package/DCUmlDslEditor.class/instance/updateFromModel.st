event handling
updateFromModel
	model ifNil: [ ^ self ].
	editor text: (exporter export: model)