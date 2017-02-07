grammar
defaultValue
	^ (#blank asParser star , $= asParser , (#any asParser starLazy: #endOfLine asParser and))
		==> [ :nodes | (nodes third joinUsing: '') trim ]