accessing - icons
ruleIcon
	"Private - Generated method"
	^ self icons
		at: #ruleIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self ruleIconContents base64Decoded readStream) ]