hooks
createModel
	^ self model ifNil: [ self modelClass subclass: source model superclass: target model ]