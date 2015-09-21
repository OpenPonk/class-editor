*DynaCASE-ClassEditor-Extensions
multiplicity
	<MSEProperty: #multiplicity type: #DCFAMIXMultiplicity>
	<MSEComment: 'A multiplicity of the attribute'>
	^ self privateState propertyAt: #multiplicity ifAbsentPut: [ DCFAMIXMultiplicity new ]