initialization
initialize
	super initialize.
	classBuilder := OPUmlClassBuilder new.
	methodBuilder := OPUmlMethodBuilder new.
	attributeBuilder := OPUmlAttributeBuilder new.
	dslBuilder := OPUmlDslBuilder new