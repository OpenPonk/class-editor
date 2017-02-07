*OpenPonk-ClassEditor-FAMIX
isCollection
	<MSEProperty: #isCollection type: #Boolean>
	<MSEComment: 'Is this attribute a collection?'>
	<derived>
	^ self multiplicity upper > 1