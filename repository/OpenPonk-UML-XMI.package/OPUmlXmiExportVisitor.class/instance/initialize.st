initialization
initialize
	super initialize.
	types := OrderedCollection new.
	writer := XMLWriter new.
	writer xml
		version: '1.0';
		encoding: 'UTF-8'.
	writer enablePrettyPrinting