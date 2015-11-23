accessing
statements
	^ (#newline asParser star
		, (classBlock / association / inheritance separatedBy: #newline asParser plus) withoutSeparators
		, #newline asParser star) optional
		==> [ :nodes | nodes ifNil: [ #() ] ifNotNil: [ nodes second ] ]