visitor
visitClass: aClass
	aClass isAbstract
		ifTrue: [ stream nextPut: $/ ].
	stream nextPutAll: aClass name.
	stream nextPut: Character space.
	aClass stereotypes
		ifNotEmpty:
			[ stream nextPutAll: '<<'.
			stream nextPutAll: ((aClass stereotypes collect: #name) joinUsing: ',').
			stream nextPutAll: '>>'.
			stream nextPut: Character space ].
	aClass methods isEmpty & aClass attributes isEmpty
		ifTrue: [ stream nextPutAll: '{ }'.
			^ self ].
	stream nextPut: ${.
	self line.
	aClass attributes
		do: [ :each | 
			stream nextPut: Character tab.
			self visitAttribute: each.
			self line ].
	aClass methods
		do: [ :each | 
			stream nextPut: Character tab.
			self visitMethod: each.
			self line ].
	stream nextPut: $}