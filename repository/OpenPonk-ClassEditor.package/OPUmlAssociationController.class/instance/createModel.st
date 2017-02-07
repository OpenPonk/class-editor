hooks
createModel
	^ self model ifNil: [ self modelClass source: source model target: target model ]