grammar
defaultValue
	^ #blank asParser star, $= asParser , #any asParser plus ==> [ :nodes | (nodes third joinUsing: '') trim ]