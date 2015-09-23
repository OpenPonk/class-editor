*DynaCASE-ClassEditor-FAMIX
famixClass: aClass
	self model: aClass.
	self text: #name.
	self
		emphasis: [ :cls | 
			cls isAbstract
				ifTrue: [ TextEmphasis italic ]
				ifFalse: [ #() ] ]