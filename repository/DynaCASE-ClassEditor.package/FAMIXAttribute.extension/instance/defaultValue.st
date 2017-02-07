*DynaCASE-ClassEditor-FAMIX
defaultValue
	<MSEProperty: #defaultValue type: #OPFAMIXValueSpecification>
	<MSEComment: 'A default value of an attribute.'>
	^ self privateState propertyAt: #defaultValue ifAbsentPut: [ nil ]