grammar
returnValue
	^ (Character space asParser star , $: asParser , type , multiplicity)
		==> [ :nodes | nodes allButFirst: 2 ]