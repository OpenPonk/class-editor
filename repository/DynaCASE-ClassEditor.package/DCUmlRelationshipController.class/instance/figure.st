accessing
figure
	^ self rtElement
	"^ (edge ifNil: [ edge := self createEdge ]) rtElement"