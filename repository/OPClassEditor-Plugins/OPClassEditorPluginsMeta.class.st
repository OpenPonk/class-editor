Class {
	#name : #OPClassEditorPluginsMeta,
	#superclass : #Object,
	#category : #'OPClassEditor-Plugins'
}

{ #category : #toolbar }
OPClassEditorPluginsMeta class >> generatorToolbarMenu: aBuilder [
	<dcEditorToolbarMenu: #CormasUmlClassPlugin>
	(aBuilder item: 'Generate VW Code...')
		action: [ CECMVWGeneratorWizard openOn: aBuilder model diagramController model ]
 	"(aBuilder item: 'Generate Code...')
		action: [ DCUmlCodeGeneratorWizard openOn: aBuilder model diagramController model ].
	(aBuilder item: 'Import Code...')
		action: [ DCUmlCodeImporterWizard openOn: aBuilder model diagramController model ]"
]
