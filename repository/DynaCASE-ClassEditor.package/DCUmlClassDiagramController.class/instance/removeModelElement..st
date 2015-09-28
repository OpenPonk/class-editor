removing
removeModelElement: aModelElement
	self removeControllerOf: aModelElement.
	self ensureNotInModel: aModelElement.

	self updateView