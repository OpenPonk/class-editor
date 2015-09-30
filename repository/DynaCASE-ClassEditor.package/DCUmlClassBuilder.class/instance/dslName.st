accessing
dslName
	^ (symbol ==> [ :smb | Array with: smb with: false ])
		/
			(($/ asParser , symbol , $/ asParser) ==> [ :nodes | Array with: nodes second with: true ])