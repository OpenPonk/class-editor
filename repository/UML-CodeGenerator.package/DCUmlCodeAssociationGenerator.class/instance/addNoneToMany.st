templates
addNoneToMany
	^ 'add{nameSg}: {param}
	({name} includes: {param}) ifTrue: [ ^ self ].
	{name} add: {param}'