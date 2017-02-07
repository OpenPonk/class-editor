*DynaCASE-ClassEditor-Updating
update
	self rtElement update.
	self view ifNotNil: [ self view signalUpdate ]