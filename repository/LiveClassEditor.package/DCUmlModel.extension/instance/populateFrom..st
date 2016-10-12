*LiveClassEditor-Model-Extensions
populateFrom: aPackage
	aPackage definedClasses
		do: [ :each | 
			| cls |
			cls := FAMIXClass named: each name.
			self add: cls.
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
								yourself) ] ]