# Class Diagram DSL

A model of a class diagram can be created via textual notation.

Note however that not all features of UML are supported. This limitation is caused by lack of support of features in the underlying meta-model. The rule of thumb is, if it is not mentioned in this document, it is not supported.

```txt
Person {
	name : String
	contact: Contact[1..*]
}

Teacher {
	gradeTests:(test: Test[*]): Number[*]
}

Teacher extends Role;
Student >> Role;
President >> Role;

Person --> roles Role[*];

President president --- university University;
University[1] university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];
```

![diagram](figures/diagram.png)

### Parsing

To parse the above text and open a diagram, run

```st
' ... DSL ... ' asClassDiagram open
```
or
```st
(DCUmlDslParser parse: ' ... DSL ... ') open
```


### Exporting

To export your model back into the DSL use `DCUmlDslExporter`.

```
model := (DCUmlDsLParser parse: '... DSL ...').

DCUmlDslExporter export: model. "returns a DSL string"
```

Keep in mind that there are often multiple ways how the same thing can be represented, for example:
```
id
id : Object
id : Object[1]
id : Object[1..1]

"or"

names : String[*]
names : String[0..*]
```

The exporter will always use the minimal version available. In the examples above it would be the first option.


## Class definition

Create an empty class `Class`:
```
Class { }
```

![Class definition](figures/class-def.png)


### Stereotypes

Currently only class stereotypes are supported.

```txt
ParticipantKind <<enumeration>> { }
```

![Class stereotype](figures/class-stereotype.png)


### Namespaces

Use `::` to separate namespaces and create FQN. Additionally you can prepend `::` before the whole name, which is useful for describing global objects.

```txt
::Object { }
DynaCASE::Object { }

DynaCASE::Object >> ::Object;
```

![Inheritance with namespaces](figures/ns-inheritance.png)

### Inheritance

Create an empty class `SubClass` as a subclass of a `ParentClass`. If the parent class wasn't defined the model is ill-defined.

To add inheritance, use

<pre>
<del>SubClass < ParentClass { }</del> "@todo"

SubClass >> ParentClass;
"or"
SubClass extends ParentClass;
</pre>

## Common properties

### Visibility

Visibility is expressed by prefixing a line with a specific character.

* `+` — public
* `-` — private
* `#` — protected

### Multiplicity

Multiplicity is denoted with a `<lower-bound>..<upper-bound>` string.

* `<lower-bound>` is always a non-negative number,
* `<upper-bound>` is a non-negative number, or a star `*` representing unlimited upper bound.

Furthermore if both bounds are equal, or the lower bound is `0` and upper bound `*`, then the lower bound can be ommited.

Examples:

full range | shortcut
---------- | --------
1..1|(1..1 is the default multiplicity, no need to specify at all)
0..1|0..1 (no shortcut)
10..10|10
0..\*|\*

> Designators (`isUnique` and `isOrdered`) are not supported.

### Abstract and Static

To specify an element as abstract, prefix it's name with slash `/`.

```st
/AbstractClass {}

/abstractMethod(Type param) : nil
```

Static elements are prefixed with underscore `_`.


```st
_staticMethod()
_classVariable
```

When combined, the order doesn't matter.

```st
/Abstract {
	_static
	_static()
	/abstract()
	_/staticAbstract()
	/_abstractStatic()
}
```

![Abstract](figures/abstract.png)


## Attributes

```st
<property-name> : [<Type>[<multiplicity>]] [ = <defaultValue>]
```

The only mandatory segment is `<property-name>`, however adding multiplicity also implies type.

Examples:

```st
Mixin {
	id "default type Object"
	name : String "default multiplicity 1..1"
	middleNames : String[*] "default type nil"
	_workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)
}
```

![Attributes](figures/attributes.png)

> Property modifiers are not supported.

## Methods (Operations)

Only name and parentheses are required.

Note that operations describing Pharo methods should be named accordingly (with colons).

```st
<operation> ::= <name>'('[<parameters>]')'[ ':' <returnType>[<multiplicity>]]
<parameters> ::= <parameter>[ ',' <parameter> ]*
<parameter> ::= <name>[':'<Type>[<multiplicity>]]
```

Examples:

```st
Behavior {
	function()
	inject:into:(aValue, aCollection)
	add:afterIndex:(anObject : Object, anIndex: Integer) : Object
	reject:(rejectBlock : BlockClosure[1]) : Object[*]
}
```

![Methods](figures/methods.png)

## Associations

Only binary associations are supported.

```
SourceClass[range] sourceName --- targetName TargetClass[range] : associationName;
```

> @todo: allow quoted space-separated sourceName/targetName/associationName


All names and both multiplicity ranges are optional. To use aggregation or composition, or explicitly define a navigable end point use the appropriate symbols as shown.

```
Class[0..1] class --- operations Operation[*]; association
Community[*] memberships <>-- members Person[*]; aggregation
University[1] university <*>-- departments Department[*]; composition
Order[*] --> products Product[1..*]; navigable in a single directon
```

![Associations](figures/association-types.png)

