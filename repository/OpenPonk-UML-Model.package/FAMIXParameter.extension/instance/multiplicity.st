*OpenPonk-UML-Model
multiplicity
	<MSEProperty: #multiplicity type: #OPFAMIXMultiplicity>
	<MSEComment: 'A multiplicity of the attribute'>
	^ self privateState propertyAt: #multiplicity ifAbsentPut: [ OPFAMIXMultiplicity new ]