Class {
	#name : 'OPUmlAttributeLabel',
	#superclass : 'OPUmlClassItemLabel',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'serialization' }
OPUmlAttributeLabel >> backupModelElementFor: aModelReference [

	^ OPUMLProperty new
		  uuid: aModelReference uuid;
		  name: '!!!__FAILED_TO_LOAD__!!!';
		  owningClass: self owningElement owningElement modelElement;
		  yourself
]
