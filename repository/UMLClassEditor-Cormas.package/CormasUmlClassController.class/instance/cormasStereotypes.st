accessing
cormasStereotypes
	| cls dict depth |
	"((CormasNS.Kernel.Entity withAllSubclasses
		select: [ :each | each environment = CormasNS.Kernel ])
		collect: [ :each | Array with: each superclass name with: each name ]) asArray."
	cls := #(#(Object Entity) #(Entity SpatialEntity) #(Entity Agent) #(Entity PassiveObject) #(SpatialEntity SpatialEntityElement) #(SpatialEntity SpatialEntitySet) #(SpatialEntityElement SpatialEntityCell) #(SpatialEntitySet SpatialEntityAggregate) #(SpatialEntitySet SpatialEntityNotConnex) #(Agent AgentComm) #(Agent AgentLocation) #(Agent Group) #(AgentComm GroupComm) #(AgentLocation GroupLocation) #(AgentLocation AgentCommLocation) #(AgentCommLocation GroupCommLocation) #(PassiveObject ObjectLocation) #(PassiveObject NetworkEntity) #(ObjectLocation NetworkComponentEntity) #(NetworkComponentEntity ArcEntity) #(NetworkComponentEntity NodeEntity)).
	dict := (cls collect: [ :each | each second -> each first ]) asDictionary.
	depth := nil.
	depth := [ :key | dict at: key ifPresent: [ :val | 1 + (depth value: val) ] ifAbsent: [ -1 ] ].
	^ {#CormasModel -> 0} , (dict keys collect: [ :each | each -> (depth value: each) ])
		sorted: [ :a :b | a value < b value or: [ a value = b value & (a key < b key) ] ]