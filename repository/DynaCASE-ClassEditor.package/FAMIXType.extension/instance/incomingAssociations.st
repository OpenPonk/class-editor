*DynaCASE-ClassEditor-FAMIX
incomingAssociations
	<MSEProperty: #incomingAssociations type: #DCFAMIXBinaryAssociation opposite: #target>
	<multivalued>
	<derived>
	<MSEComment: 'Associations ending in this entity.'>
	<package: #DC>
	^ self privateState
		attributeAt: #incomingAssociations
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #target: ]