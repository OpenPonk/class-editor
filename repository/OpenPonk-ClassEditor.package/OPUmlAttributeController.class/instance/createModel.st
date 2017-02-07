model
createModel
	^ self model
		ifNil:
			[ 
			| m |
			m := self modelClass uniqueNameIn: classController model.
			classController model addAttribute: m.
			m ]