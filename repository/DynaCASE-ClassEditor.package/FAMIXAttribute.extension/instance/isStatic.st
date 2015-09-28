*DynaCASE-ClassEditor-FAMIX
isStatic
	<MSEProperty: #isStatic type: #Boolean>
	<MSEComment: 'Does the method belong to the class or instance?'>
	^ self privateState propertyAt: #isStatic ifAbsentPut: [ false ]