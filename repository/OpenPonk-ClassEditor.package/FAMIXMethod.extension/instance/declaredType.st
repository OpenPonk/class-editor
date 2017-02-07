*OpenPonk-ClassEditor-FAMIX
declaredType
	<MSEProperty: #declaredType type: #FAMIXType opposite: #behavioursWithDeclaredType>
	<MSEComment: 'Type of the behavioral entity, if any'>
	^ self parameters
		detect: [ :each | each isReturn ]
		ifFound: [ :each | each declaredType ]
		ifNone: [ nil ]