accessing
associationName
	^ (#blank asParser star , $: asParser , #blank asParser star , endName)
		==> [ :nodes | nodes fourth ]