*DynaCASE-ClassEditor-FAMIX
famixUpdate
	[ self figures size > 1 ] whileTrue: [ self remove: self figures last ].
	self model attributes
		ifNotEmpty:
			[ :attrs | 
			self add: self newCompartment.
			attrs do: [ :each | self figures last newLabel: [ :fig | fig famixAttribute: each ] ] ].
	self model methods
		ifNotEmpty:
			[ :attrs | 
			self add: self newCompartment.
			attrs do: [ :each | self figures last newLabel: [ :fig | fig famixMethod: each ] ] ].
	self changed