adding
to: anObject at: aSlot put: aValue
	(self ensureInstanceFor: anObject) slots at: aSlot put: aValue