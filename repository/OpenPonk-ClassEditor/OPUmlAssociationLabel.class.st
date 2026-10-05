"
An edge label representing the primary name of a UML association, positioned along the center of the association line.
"
Class {
	#name : 'OPUmlAssociationLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'adding' }
OPUmlAssociationLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
OPUmlAssociationLabel >> defaultText [
	^ String streamContents: [ :stream |
		  self modelElement isDerived ifTrue: [ stream nextPut: $/ ].
		  (self modelElement name ifNil: [ '' ]) trim ifNotEmpty: [ :cleanName |
			  stream << cleanName ].
		  self properties ifNotEmpty: [ :properties |
			  stream position > 0 ifTrue: [ stream space ].
			  stream nextPut: ${.
			  properties do: [ :each | stream << each ] separatedBy: [ stream << ', ' ].
			  stream nextPut: $} ] ]
]

{ #category : 'accessing' }
OPUmlAssociationLabel >> properties [
	| properties |
	properties := OrderedCollection new.
	self modelElement appliedStereotypes do: [ :stereotype |
		| umlMetaClass |
		umlMetaClass := stereotype umlMetaClass.
		umlMetaClass allAttributes
			reject: [ :attribute | attribute name beginsWith: 'base_' ]
			thenDo: [ :attribute |
				(stereotype perform: attribute name asSymbol) ifNotNil: [ :value |
					(value isKindOf: Boolean)
						ifTrue: [ value ifTrue: [ properties add: attribute name ] ]
						ifFalse: [ properties add: attribute name , '=' , value asString ] ] ] ].
	^ properties
]
