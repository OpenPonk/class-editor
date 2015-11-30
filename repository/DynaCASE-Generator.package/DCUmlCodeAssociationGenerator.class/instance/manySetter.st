templates
manySetter
	^ '{name}: {param}
	[ {name} isNotEmpty ] whileTrue: [ self remove{nameSg}: {name} anyOne ].
	{param} do: [ :each | self add{nameSg}: each ]'