examples
sampleDsl
	'::MooseModel::

DCProject
--
dcID : UUID
dcName : String
--
addDiagram(aDiagram : DCDiagram)
layoutFor(aDiagram : DCDiagram) : Dictionary

DCModelObject

DCNamedElement < DCModelObject

DCDiagram < DCModelObject

DCDiagram <-> DCNamedElement
r1=owner
m1=0..1
r2=elements
m2=0..*

DCProject -> DCDiagram
m1=0..1
r2=diagrams
m2=0..*

DCModelObject <-> DCModelObject
m1=0..*
r2=owner
m2=0..1'