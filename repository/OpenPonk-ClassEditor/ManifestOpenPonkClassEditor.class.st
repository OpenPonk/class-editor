"
I store metadata for the OpenPonk-ClassEditor package. This package implements the UML Class Diagram editor, including controllers, ViewModels, visual shapes, and UI plugins specific to class modeling and profiling.
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
