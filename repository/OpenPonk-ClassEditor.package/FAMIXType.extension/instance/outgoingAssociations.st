*OpenPonk-ClassEditor-FAMIX
outgoingAssociations
	<MSEProperty: #outgoingAssociations type: #OPFAMIXBinaryAssociation opposite: #source>
	<multivalued>
	<derived>
	<MSEComment: 'Associations originating from this entity.'>
	<package: #OP>
	^ self privateState
		attributeAt: #outgoingAssociations
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #source: ]