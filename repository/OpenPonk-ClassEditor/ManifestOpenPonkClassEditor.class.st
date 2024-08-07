"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestOpenPonkClassEditor',
	#superclass : 'PackageManifest',
	#category : 'OpenPonk-ClassEditor-Manifest',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestOpenPonkClassEditor class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#OPUmlClassEditorPlugin #mergeModels: #false)) #'2021-09-06T22:28:58.964+02:00') )
]

{ #category : 'code-critics' }
ManifestOpenPonkClassEditor class >> ruleReTestClassNotInPackageWithTestEndingNameV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'OpenPonk-ClassEditor')) #'2020-05-27T11:08:54.086665+02:00') )
]
