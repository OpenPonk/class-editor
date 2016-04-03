as yet unclassified
symbolMapping
	^ Mapping
		ifNil: [ Mapping := Dictionary
				with: $+ -> #public
				with: $- -> #private
				with: $# -> #protected
				with: $~ -> #package ]