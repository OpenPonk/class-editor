tests - diagram
testPositionsOfContentOfAClass
	| class operation operationController nameLabelRectangle operationLabelRectangle classRectangle elements |
	class := OPUMLClass new.
	class name: 'AClass'.
	operation := OPUMLOperation new.
	operation name: 'anOperation'.
	class ownedOperations add: operation.
	operationController := OPUmlOperationController new.
	operationController model: operation.	
	diagramController model packagedElements add: class.
	diagramController rebuild.
	elements := diagramController view elements.
	nameLabelRectangle := (elements
		detect: [ :any | any model class = OPUmlNameLabel ])
		encompassingRectangle.
	operationLabelRectangle := (elements
		detect: [ :any | any model class = OPUmlLabel ])
		encompassingRectangle.
	classRectangle := (elements
		detect: [ :any | any model isKindOf: OPUmlClassShape ])
		encompassingRectangle.
	"(elements collect: [ :e | e model -> e encompassingRectangle ])
		inspect."
	self
		assert: (classRectangle containsRect: nameLabelRectangle)
		description: 'Name of class is outside of class shape'.
	self
		assert: (classRectangle containsRect: operationLabelRectangle)
		description: 'Name of operation is outside of class shape'.
	self
		assert:
			(operationLabelRectangle corner x >= nameLabelRectangle origin x
				and: [ operationLabelRectangle corner y >= nameLabelRectangle origin y
						and: [ operationLabelRectangle origin x <= nameLabelRectangle corner x
								and: [ operationLabelRectangle origin y <= nameLabelRectangle corner y ] ] ])
		description: 'Name of operation is overlapping name of class'.	"intersection without caring if they touch (Rectangle>>#intersects: returns true if they even touch)"
	^ self
		assert: nameLabelRectangle bottom <= operationLabelRectangle top
		description: 'Name of operation is not below name of class'