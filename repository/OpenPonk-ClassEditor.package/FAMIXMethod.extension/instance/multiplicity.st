*OpenPonk-ClassEditor-FAMIX
multiplicity
	<MSEProperty: #multiplicity type: #OPFAMIXMultiplicity>
	<MSEComment: 'A multiplicity of the attribute'>
	^ self parameters detect: #isReturn ifFound: #multiplicity ifNone: [ nil ]