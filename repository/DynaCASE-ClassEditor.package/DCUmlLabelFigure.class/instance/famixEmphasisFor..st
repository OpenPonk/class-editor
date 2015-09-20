*DynaCASE-ClassEditor-FAMIX
famixEmphasisFor: aModel
	| emph |
	emph := Set new.
	aModel isStatic
		ifTrue: [ emph add: TextEmphasis underlined ].
	aModel isAbstract
		ifTrue: [ emph add: TextEmphasis italic ].
	^ emph