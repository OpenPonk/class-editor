examples
exampleClass
	| v cls |
	v := RTView new.
	cls := self sampleClass.
	cls renderIn: v.
	v open