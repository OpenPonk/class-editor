grammar
defaultValue
	^ $= asParser , #any asParser plus ==> [ :nodes | (nodes second joinUsing: '') trim ]