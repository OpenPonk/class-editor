accessing
ensureClass: anEnum
	| oldPkg newPkg parentName |
	newPkg := anEnum parentPackage ifNil: [ 'Unclassified' ] ifNotNil: #name.
	oldPkg := anEnum smalltalkClass ifNil: [ newPkg ] ifNotNil: [ :cls | cls package name ].
	newPkg = oldPkg
		ifFalse: [ self
				error:
					('Cannot move class {1} from package {2} to {3}.'
						format: (Array with: anEnum name with: oldPkg with: newPkg)) ].
	parentName := anEnum superInheritances
		ifEmpty: [ 'Object' ]
		ifNotEmpty: [ :supers | supers first superclass name ].
	^ Object
		subclass: anEnum name
		instanceVariableNames: ''
		classVariableNames: ''
		category: newPkg