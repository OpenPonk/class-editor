*DynaCASE-ClassEditor-FAMIX
outgoingAssociations
	<MSEProperty: #outgoingAssociations type: #DCFAMIXBinaryAssociation opposite: #source>
	<multivalued>
	<derived>
	<MSEComment: 'Associations originating from this entity.'>
	<package: #DC>
	^ self privateState
		attributeAt: #outgoingAssociations
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #source: ]