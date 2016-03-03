*DynaCASE-ClassEditor-FAMIX
stereotypes
	<MSEProperty: #stereotypes type: #DCFAMIXStereotype>
	<multivalued>
	<MSEComment: 'Stereotypes associated with this entity.'>
	<package: #DC>
	^ self privateState attributeAt: #stereotypes ifAbsentPut: [ OrderedCollection new ]