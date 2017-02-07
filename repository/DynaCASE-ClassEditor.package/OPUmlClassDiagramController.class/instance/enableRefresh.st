userinterface
enableRefresh
	| uninstall |
	uninstall := [ :cls | 
	(cls includesSelector: #refreshFigure)
		ifTrue: [ (cls >> #refreshFigure) ast links ifNotNilDo: [ :l | l do: #uninstall ] ] ].
	OPUmlElementController withAllSubAndSuperclassesDo: [ :each | uninstall value: each ]