accessing
aggregation
	<MSEProperty: #aggregation type: #String>
	<MSEComment: 'AggregationKind'>
	<package: #DC>
	^ aggregation ifNil: [ DCUmlAggregationKind none ]