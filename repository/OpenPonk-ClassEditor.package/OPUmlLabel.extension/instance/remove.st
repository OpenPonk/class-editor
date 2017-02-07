*OpenPonk-ClassEditor-Manipulation
remove
	| view |
	view := self rtElement view.
	view ifNil: [ ^ self ].
	self rtElement remove.
	view signalUpdate