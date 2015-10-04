*DynaCASE-ClassEditor-Updating
update
	self rtEdge update.
	self view ifNotNil: [ self view signalUpdate ]