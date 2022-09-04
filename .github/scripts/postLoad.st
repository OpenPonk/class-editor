PharoLightTheme beCurrent.
Smalltalk at: #OPUmlClassEditorPlugin ifPresent: [ :plugin | plugin withAllSubclasses flatCollectAsSet: #defaultProfiles ].
PolymorphSystemSettings setDesktopLogoWith: OPCoreIcons logo asMorph.
