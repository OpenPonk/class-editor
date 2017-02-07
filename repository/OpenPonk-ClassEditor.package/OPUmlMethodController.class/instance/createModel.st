model
createModel
	^ self model
		ifNil:
			[ 
			| m |
			m := self modelClass uniqueNameIn: classController model.
			classController model addMethod: m.
			m ]