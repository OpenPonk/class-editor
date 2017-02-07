accessing
block
	^ (${ asParser , #space asParser star , statements , #space asParser star , $} asParser)
		==> [ :nodes | nodes third ]