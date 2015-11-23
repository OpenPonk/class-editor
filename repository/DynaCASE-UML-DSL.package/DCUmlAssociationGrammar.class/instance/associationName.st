accessing
associationName
	^ #newline asParser
		/ (#blank asParser star , $: asParser , #blank asParser star , endName)
		==> [ :nodes | 
			nodes = Character cr
				ifTrue: [ nil ]
				ifFalse: [ nodes third ] ]