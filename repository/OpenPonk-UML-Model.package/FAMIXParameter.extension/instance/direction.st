*OpenPonk-UML-Model
direction
	<MSEProperty: #direction type: #OPUmlParameterDirectionKind>
	<MSEComment: 'Parameter direction type'>
	^ self privateState propertyAt: #direction ifAbsentPut: [ OPUmlParameterDirectionKind in ]