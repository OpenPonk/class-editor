*OpenPonk-ClassEditor-FAMIX
stereotypes
	<MSEProperty: #stereotypes type: #OPFAMIXStereotype>
	<multivalued>
	<MSEComment: 'Stereotypes associated with this entity.'>
	<package: #OP>
	^ self privateState attributeAt: #stereotypes ifAbsentPut: [ OrderedCollection new ]