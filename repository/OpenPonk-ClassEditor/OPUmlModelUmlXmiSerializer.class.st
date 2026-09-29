"
I am a specific serializer configuration for exporting OpenPonk UML models into standard UML XMI 2.x format.
"
Class {
	#name : 'OPUmlModelUmlXmiSerializer',
	#superclass : 'OPUmlModelSerializer',
	#category : 'OpenPonk-ClassEditor-Persistence',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Persistence'
}

{ #category : 'formatting' }
OPUmlModelUmlXmiSerializer class >> formatName [

	^ #'uml-xmi'
]
