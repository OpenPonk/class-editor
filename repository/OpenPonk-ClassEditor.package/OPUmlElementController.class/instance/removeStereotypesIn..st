removing
removeStereotypesIn: aModel
	[ aModel appliedStereotypes isNotEmpty ]
		whileTrue: [ aModel unapplyStereotype: aModel appliedStereotypes first ]