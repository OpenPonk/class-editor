figures
addStereotype
	(stereotypeLabel := DCUmlKeywordLabel new)
		text: '<<' , ((self model stereotypes collect: #name) joinUsing: ',') , '>>';
		localStyle: (DCUmlStyle new fontSize: 10);
		owningElement: self diagramElement