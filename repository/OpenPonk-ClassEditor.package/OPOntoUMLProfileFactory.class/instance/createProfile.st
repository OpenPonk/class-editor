as yet unclassified
createProfile
	| profile classMetaclass sortals mixins associationMetaclass associations |
	profile := OPUMLProfile new name: 'OntoUML [WIP]'.
	classMetaclass := OPUMLClass new name: 'Class'.
	sortals := #(Kind Quantity Collective SubKind Phase Role).
	mixins := #(RoleMixin Mixin Category).
	profile packagedElements add: classMetaclass.
	(sortals , mixins) sorted
		do: [ :each | profile packagedElements add: (self newStereotype: each to: classMetaclass) ].
	associationMetaclass := OPUMLClass new name: 'Association'.
	associations := #(Formal Material).
	associations sorted
		do:
			[ :each | profile packagedElements add: (self newStereotype: each to: associationMetaclass) ].
	^ profile