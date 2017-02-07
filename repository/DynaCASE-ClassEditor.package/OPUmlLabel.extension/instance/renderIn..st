*DynaCASE-ClassEditor-Manipulation
renderIn: aView
	self rtElement view ifNotNil: [ ^ self ].
	aView add: self rtElement.
	aView signalUpdate