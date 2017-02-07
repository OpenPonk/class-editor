*OpenPonk-ClassEditor-FAMIX
protocol
	<MSEProperty: #protocol type: #String>
	<MSEComment: 'The method''s protocol'>
	^ self privateState propertyAt: #protocol ifAbsentPut: [ 'as yet unclassified' ]