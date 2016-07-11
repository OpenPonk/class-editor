hooks
createModel
	| associations |
	model := 'University[1] university <*>-- departments Department[*];' asClassDiagram.
	university := model detect: [ :each | each name = #University ].
	department := model detect: [ :each | each name = #Department ].
	associations := model select: #isBinaryAssociation.
	uniToDept := associations
		detect: [ :each | (each source name = #University & each target name) = #Department ]