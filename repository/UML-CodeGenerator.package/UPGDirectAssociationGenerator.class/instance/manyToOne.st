templates
manyToOne
	^ '{name}: {param}
	|oldRef|
	{name} = {param} ifTrue: [ ^ self ].
	oldRef := {name}.
	{name} := {param}.
	"oldRef ifNotNil: [ oldRef remove{otherNameSgCapitalized}: self ]."
	oldRef ifNotNil: [ oldRef forgetAttribute: #{otherNameSg} ].
	{name} ifNotNil: [ {name} add{otherNameSgCapitalized}: self ]'