accessing
statements
	^ ((classBlock / association separatedBy: #newline asParser plus) withoutSeparators , #newline asParser star)
		==> [ :nodes | nodes first ]