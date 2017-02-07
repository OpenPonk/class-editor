*DynaCASE-UML-Model
visibility
	<MSEProperty: #visibility type: #OPUmlVisibilityKind>
	<MSEComment: 'VisibilityKind'>
	^ self privateState propertyAt: #visibility ifAbsentPut: [ nil ]