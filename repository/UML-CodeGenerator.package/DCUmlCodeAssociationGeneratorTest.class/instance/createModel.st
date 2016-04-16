instance creation
createModel
	| associations |
	model := 'President president --- university University;
University[1] university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];
President --> name Name;
Teacher --> names Name[*];' asClassDiagram.
	president := model detect: [ :each | each name = #President ].
	university := model detect: [ :each | each name = #University ].
	department := model detect: [ :each | each name = #Department ].
	teacher := model detect: [ :each | each name = #Teacher ].
	name := model detect: [ :each | each name = #Name ].
	associations := model select: #isBinaryAssociation.
	oneToOne := associations
		detect: [ :each | (each source name = #President & each target name) = #University ].
	oneToMany := associations
		detect: [ :each | (each source name = #University & each target name) = #Department ].
	manyToMany := associations
		detect: [ :each | (each source name = #Department & each target name) = #Teacher ].
	noneToOne := associations
		detect: [ :each | (each source name = #President & each target name) = #Name ].
	noneToMany := associations
		detect: [ :each | (each source name = #Teacher & each target name) = #Name ]