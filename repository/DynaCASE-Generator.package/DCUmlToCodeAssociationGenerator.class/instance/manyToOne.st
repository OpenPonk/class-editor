templates
manyToOne
	^ '{name}: {param}
	|oldRef|
	{name} = {param} ifTrue: [ ^ self ].
	oldRef := {name}.
	{name} := {param}.
	oldRef ifNotNil: [ oldRef remove{otherNameSg}: self ].
	{name} ifNotNil: [ {name} add{otherNameSg}: self ]'