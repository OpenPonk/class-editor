userinterface
enableRefresh
	| uninstall |
	uninstall := [ :cls | 
	(cls includesSelector: #refreshFigure)
		ifTrue: [ (cls >> #refreshFigure) ast links ifNotNil: [ :l | l do: #uninstall ] ] ].
	OPUmlOldElementController withAllSubAndSuperclassesDo: [ :each | uninstall value: each ]