events - registering
registerModelEvents: aModel
	super registerModelEvents: aModel.
	aModel announcer when: DCModelContentReplaced do: [ self rebuild ]