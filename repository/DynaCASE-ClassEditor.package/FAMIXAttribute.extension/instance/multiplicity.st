*DynaCASE-ClassEditor-Extensions
multiplicity
	<MSEProperty: #multiplicity type: #DCUmlMultiplicity>
	<MSEComment: 'A multiplicity of the attribute'>
	^ self privateState attributeAt: #multiplicity ifAbsentPut: [ DCUmlMultiplicity new ]