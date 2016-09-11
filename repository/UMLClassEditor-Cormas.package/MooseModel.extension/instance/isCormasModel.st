*UMLClassEditor-Cormas
isCormasModel
	<MSEProperty: #isCormasModel type: #Boolean>
	<MSEComment: 'Does this MooseModel represent a Cormas model?'>
	^ self privateState propertyAt: #isCormasModel ifAbsentPut: [ false ]