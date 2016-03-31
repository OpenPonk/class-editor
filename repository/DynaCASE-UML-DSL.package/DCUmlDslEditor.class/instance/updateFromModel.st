event handling
updateFromModel
	| text |
	model ifNil: [ ^ self ].
	text := (exporter export: model) asText.
	editor text: text