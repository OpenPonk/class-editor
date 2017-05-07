events - registering
registerModelEvents: aModel
	super registerModelEvents: aModel.
	aModel announcer
		when: OPModelContentReplaced
		do: [ self rebuild.
			self applyAutoLayout ]