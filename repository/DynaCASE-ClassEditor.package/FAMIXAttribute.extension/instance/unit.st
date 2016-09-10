*DynaCASE-ClassEditor-FAMIX
unit
	<MSEProperty: #unit type: #String>
	<MSEComment: 'Unit (metatype) of the attribute.'>
	^ self privateState propertyAt: #unit ifAbsentPut: [ nil ]