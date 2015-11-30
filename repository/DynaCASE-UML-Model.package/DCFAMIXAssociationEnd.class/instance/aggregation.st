accessing
aggregation
	<MSEProperty: #aggregation type: #Symbol>
	<MSEComment: 'AggregationKind'>
	<package: #DC>
	^ aggregation ifNil: [ DCUmlAggregationKind none ]