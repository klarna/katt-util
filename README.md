# KATT util [![Build Status][2]][1]

KATT utilities for KATT blueprints.


## Install

```bash
npm install katt-util
```


## Usage

### Linter

```bash
katt-lint FOLDER/FILE ...
```

```coffee
kattUtil = require 'katt-util'
kattBlueprint = '...'

errors = kattUtil.lint kattBlueprint

if errors.length # if there are errors
  console.log errors.length[0] # {type, native, details}
```

### Formatter

```bash
katt-format FOLDER/FILE ...
```

```coffee
kattUtil = require 'katt-util'
kattBlueprint = '...'

beautifulKattBleuprint = kattUtil.format kattBlueprint
```


## License

[Apache 2.0](LICENSE)


  [1]: https://travis-ci.org/klarna/katt-util
  [2]: https://travis-ci.org/klatna/katt-util.png
