*DynaCASE-ClassEditor-Extensions
multiplicity
	<MSEProperty: #multiplicity type: #DCFAMIXMultiplicity>
	<MSEComment: 'A multiplicity of the attribute'>
	^ self privateState attributeAt: #multiplicity ifAbsentPut: [ DCFAMIXMultiplicity new ]