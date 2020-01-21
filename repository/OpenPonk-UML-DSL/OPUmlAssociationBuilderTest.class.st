Class {
	#name : #OPUmlAssociationBuilderTest,
	#superclass : #OPUmlAssociationGrammarTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #accessing }
OPUmlAssociationBuilderTest >> parserClass [
	^ OPUmlAssociationBuilder
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testAssociation1 [
	super testAssociation1.
	self assert: result class equals: OPFAMIXBinaryAssociation.
	self assert: result source name equals: 'Left'.
	self assert: result target name equals: 'Right'.
	self assert: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testAssociation3 [
	super testAssociation3.
	self assert: result source name equals: 'Left'.
	self assert: result target name equals: 'Right'.
	self assert: result sourceEnd name equals: 'leftRole'.
	self assert: result targetEnd name equals: 'rightRole'.
	self assert: result name equals: 'name'
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testAssociationName [
	super testAssociationName.
	self assert: result equals: 'name'
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testAssociationNs [
	super testAssociationNs.
	self assert: result source name equals: '::Object'.
	self assert: result target name equals: 'NS::Object'
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testAssociationNs1 [
	super testAssociationNs1.
	self assert: result source name equals: 'NS::Object'.
	self assert: result target name equals: '::Object'
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testEndName [
	super testEndName.
	self assert: result equals: 'name'
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testEndSymbol1 [
	self parse: '>' rule: #endSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind none.
			true}
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testLeftEnd [
	self parse: 'Left -' rule: #leftEnd.
	self assert: result first equals: 'Left'.
	self assert: result second class equals: OPFAMIXProperty.
	self assert: result second name equals: nil.
	self assert: result third equals: OPUmlAggregationKind none.
	self assert: result fourth equals: false
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testLeftEndWithRole [
	self parse: 'Left role -' rule: #leftEnd.
	self assert: result first equals: 'Left'.
	self assert: result second class equals: OPFAMIXProperty.
	self assert: result second name equals: 'role'.
	self assert: result third equals: OPUmlAggregationKind none.
	self assert: result fourth equals: false
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testNavigable [
	super testNavigable.
	self assert: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testNavigable1 [
	super testNavigable1.
	self deny: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testNavigable2 [
	super testNavigable2.
	self assert: result sourceEnd isNavigable.
	self deny: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testNavigable3 [
	super testNavigable3.
	self assert: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testNavigable4 [
	super testNavigable4.
	self deny: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testNavigable5 [
	super testNavigable5.
	self assert: result sourceEnd isNavigable.
	self assert: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testNavigable6 [
	super testNavigable6.
	self assert: result sourceEnd isNavigable.
	self deny: result targetEnd isNavigable
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testRightEnd [
	self parse: '- Right' rule: #rightEnd.
	self assert: result first equals: 'Right'.
	self assert: result second class equals: OPFAMIXProperty.
	self assert: result second name equals: nil.
	self assert: result third equals: OPUmlAggregationKind none.
	self assert: result fourth equals: false
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testRightEndWithRole [
	self parse: '- role Right' rule: #rightEnd.
	self assert: result first equals: 'Right'.
	self assert: result second class equals: OPFAMIXProperty.
	self assert: result second name equals: 'role'.
	self assert: result third equals: OPUmlAggregationKind none.
	self assert: result fourth equals: false
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testStartSymbol [
	self parse: '<*>' rule: #startSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind composite.
			false}
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testStartSymbol1 [
	self parse: '<' rule: #startSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind none.
			true}
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testTypeSymbol [
	self parse: '-' rule: #typeSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind none.
			false}
]

{ #category : #tests }
OPUmlAssociationBuilderTest >> testTypeSymbol2 [
	self parse: '<>' rule: #typeSymbol.
	self
		assert: result
		equals:
			{OPUmlAggregationKind shared.
			false}
]
