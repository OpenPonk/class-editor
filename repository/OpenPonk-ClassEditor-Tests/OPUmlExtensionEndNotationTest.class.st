"
Verifies string formatting of UML ExtensionEnd elements, including multiplicity ranges, role names, types, default values, and property modifiers.
"
Class {
	#name : 'OPUmlExtensionEndNotationTest',
	#superclass : 'TestCase',
	#instVars : [
		'extensionEnd'
	],
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'tests' }
OPUmlExtensionEndNotationTest >> testExtensionEndMultiplicityRanges [

	extensionEnd := OPUMLExtensionEnd new.
	self assert: extensionEnd notationMultiplicityRange equals: ''.
	self assert: extensionEnd notationAssociationMultiplicityRange equals: '1'.

	extensionEnd
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1).
	self assert: extensionEnd notationMultiplicityRange equals: '0..1'.
	self assert: extensionEnd notationAssociationMultiplicityRange equals: '0..1'.

	extensionEnd
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	self assert: extensionEnd notationMultiplicityRange equals: '*'.
	self assert: extensionEnd notationAssociationMultiplicityRange equals: '*'
]

{ #category : 'tests' }
OPUmlExtensionEndNotationTest >> testExtensionEndNotationString [

	extensionEnd := OPUMLExtensionEnd new.
	self assert: extensionEnd notationString equals: ''.

	extensionEnd
		visibility: OPUMLVisibilityKind public;
		isDerived: true;
		name: 'extension_Secured';
		type: (OPUMLStereotype new name: 'Secured');
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*');
		defaultValue: (OPUMLOpaqueExpression new bodies: #( 'default' ));
		isReadOnly: true;
		isOrdered: true;
		isUnique: false.
	self assert: extensionEnd notationString equals: '+ /extension_Secured : Secured[*] = default {readOnly, ordered, nonunique}'
]

{ #category : 'tests' }
OPUmlExtensionEndNotationTest >> testExtensionEndNotationStringAsRoleName [

	extensionEnd := OPUMLExtensionEnd new.
	self assert: extensionEnd notationStringAsRoleName equals: ''.

	extensionEnd
		visibility: OPUMLVisibilityKind private;
		isDerived: true;
		name: 'extension_Secured';
		type: (OPUMLStereotype new name: 'Secured');
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*');
		defaultValue: (OPUMLOpaqueExpression new bodies: #( 'default' ));
		isReadOnly: true;
		isOrdered: true;
		isUnique: false.
	self assert: extensionEnd notationStringAsRoleName equals: '- /extension_Secured[*] = default {readOnly, ordered, nonunique}'
]

{ #category : 'tests' }
OPUmlExtensionEndNotationTest >> testExtensionEndTypeWithoutName [

	extensionEnd := OPUMLExtensionEnd new
		                name: 'extensionEnd';
		                type: OPUMLStereotype new;
		                yourself.
	self assert: extensionEnd notationString equals: 'extensionEnd'
]
