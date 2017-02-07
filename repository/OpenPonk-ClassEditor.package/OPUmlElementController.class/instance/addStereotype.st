figures
addStereotype
	(stereotypeLabel := OPUmlKeywordLabel new)
		text: '<<' , ((self model stereotypes collect: #name) joinUsing: ',') , '>>';
		localStyle: (OPUmlStyle new fontSize: 10);
		owningElement: self diagramElement