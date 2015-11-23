grammar
opName
	^ ((symbol , $: asParser) plus ==> [ :nodes | nodes flatten joinUsing: '' ]) / symbol