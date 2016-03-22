*DynaCASE-UML-Model
direction
	<MSEProperty: #direction type: #DCUmlParameterDirectionKind>
	<MSEComment: 'Parameter direction type'>
	^ self privateState propertyAt: #direction ifAbsentPut: [ DCUmlParameterDirectionKind in ]