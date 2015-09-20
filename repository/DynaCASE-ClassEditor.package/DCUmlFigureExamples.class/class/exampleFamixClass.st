examples
exampleFamixClass
	| v cls |
	v := RTView new.

	cls := self sampleFamixClass.

	cls renderIn: v.

	v open