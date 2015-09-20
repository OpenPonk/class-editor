*DynaCASE-ClassEditor-Extensions
multiplicity
	<MSEProperty: #multiplicity type: #DCUmlMultiplicity>
	<MSEComment: 'A multiplicity of the attribute'>
	^ self privateState propertyAt: #multiplicity ifAbsentPut: [ DCUmlMultiplicity new ]