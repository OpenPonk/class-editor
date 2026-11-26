# OpenPonk: UML Class Editor

[![Nightly](https://github.com/OpenPonk/class-editor/actions/workflows/nightly.yml/badge.svg)](https://github.com/OpenPonk/class-editor/actions/workflows/nightly.yml) [![Coverage Status](https://coveralls.io/repos/github/OpenPonk/class-editor/badge.svg?branch=master)](https://coveralls.io/github/OpenPonk/class-editor?branch=master)

UML Class Diagram editor plugin (with UML profile support and OntoUML ecosystem integration) for the [OpenPonk](https://openponk.org) modeling platform.

## Download

Download pre-built portable archives (UML Class Diagrams + OntoUML) from [Releases](https://github.com/OpenPonk/class-editor/releases), or get the all-in-one build at [openponk.org/#download](https://openponk.org/#download).

## Installation

See [openponk.org/#direct-installation](https://openponk.org/#direct-installation) for the supported Pharo version.

```smalltalk
Metacello new
	baseline: 'OpenPonkClassEditor';
	repository: 'github://OpenPonk/class-editor';
	load: 'complete'.
```

To load only the UML Class Editor without OntoUML extensions and Git integration, use `load` (the `default` group).

## Documentation

Part of the [OpenPonk](https://openponk.org) platform. For architecture, the repository catalog, and contributing guidelines, see [`OpenPonk/.github`](https://github.com/OpenPonk/.github/blob/main/profile/README.md).
