*DynaCASE-ClassEditor-Accessing
minWidth
	^ self ownedElements ifEmpty: [ 0 ] ifNotEmpty: [ :f | f max: #minWidth ]