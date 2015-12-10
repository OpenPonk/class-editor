instance creation
createModel
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
	oneToOne := model detect: [ :each | each asString = 'President -> University' ].
	oneToMany := model detect: [ :each | each asString = 'University -> Department' ].
	manyToMany := model detect: [ :each | each asString = 'Department -> Teacher' ].
	noneToOne := model detect: [ :each | each asString = 'President -> Name' ].
	noneToMany := model detect: [ :each | each asString = 'Teacher -> Name' ].