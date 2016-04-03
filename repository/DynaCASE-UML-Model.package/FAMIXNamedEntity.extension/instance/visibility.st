*DynaCASE-UML-Model
visibility
	<MSEProperty: #visibility type: #DCUmlVisibilityKind>
	<MSEComment: 'VisibilityKind'>
	^ self privateState propertyAt: #visibility ifAbsentPut: [ nil ]