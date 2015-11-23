accessing
statements
	^ ((statement , #newline asParser star) ==> [ :nodes | nodes first ]) star