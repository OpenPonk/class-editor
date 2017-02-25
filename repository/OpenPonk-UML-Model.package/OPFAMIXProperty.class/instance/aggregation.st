accessing
aggregation
	<MSEProperty: #aggregation type: #String>
	<MSEComment: 'AggregationKind'>
	<package: #OP>
	^ aggregation ifNil: [ OPUmlAggregationKind none ]