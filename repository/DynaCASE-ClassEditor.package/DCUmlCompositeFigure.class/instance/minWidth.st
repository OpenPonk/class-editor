accessing
minWidth
	^ self figures ifEmpty: [ 0 ] ifNotEmpty: [ :f | f max: #minWidth ]