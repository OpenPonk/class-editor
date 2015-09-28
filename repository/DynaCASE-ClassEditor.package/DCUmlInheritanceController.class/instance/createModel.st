hooks
createModel
	^ self model ifNil: [ self modelClass superclass: target model subclass: source model ]