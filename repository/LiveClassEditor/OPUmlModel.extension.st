Extension { #name : 'OPUmlModel' }

{ #category : '*LiveClassEditor-Model-Extensions' }
OPUmlModel >> populateFrom: aPackage [
	| clsMapping |
	self name: aPackage name.
	clsMapping := Dictionary new.
	aPackage classes
		do: [ :each | 
			| cls |
			cls := FAMIXClass named: each name.
			self add: cls.
			clsMapping at: each put: cls.
			each instanceVariables do: [ :attr | cls addAttribute: (FAMIXAttribute named: attr) ].
			each class instanceVariables
				do: [ :attr | cls addAttribute: ((FAMIXAttribute named: attr) isStatic: true) ].
			each methods
				do: [ :meth | 
					cls
						addMethod:
							((FAMIXMethod named: meth selector)
								protocol: meth protocol;
								yourself) ].
			each class methods
				do: [ :meth | 
					cls
						addMethod:
							((FAMIXMethod named: meth selector)
								protocol: meth protocol;
								isStatic: true;
								yourself) ] ].
	aPackage classes
		do: [ :cls | 
			cls superclass = Object
				ifFalse: [ | parent |
					parent := self allClasses
						detect: [ :each | each name = cls superclass name ]
						ifFound: #yourself
						ifNone: [  FAMIXClass named: cls superclass name ].
					self add: (FAMIXInheritance subclass: (clsMapping at: cls) superclass: parent) ] ]
]
