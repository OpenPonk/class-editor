*DynaCASE-ClassEditor-FAMIX
multiplicity
	<MSEProperty: #multiplicity type: #DCFAMIXMultiplicity>
	<MSEComment: 'A multiplicity of the attribute'>
	^ self parameters detect: #isReturn ifFound: #multiplicity ifNone: [ nil ]