tests
testAssociationOneToMany
	| university department |
	model := self oneToManyAssociation.
	university := self newClassNamed: model source name.
	department := self newClassNamed: model target name.
	generator createAssociationFor: model.
	self assert: university instVarNames equals: #(departments).
	self assert: department instVarNames equals: #(university).
	self assert: university selectors equals: #(#departments #departments: #addDepartment: #removeDepartment:).
	self assert: department selectors equals: #(#university #university:).
	