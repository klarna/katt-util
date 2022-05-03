# [DEPRECATED] KATT util [![Build Status][2]][1]

---

### ⚠ Important

**This project is not maintaned anymore. Some dependencies are known to have security vulnerabilities. Install at your own risk.**

---

KATT utilities for KATT blueprints.


## Install

```bash
# NPM distribution
npm install katt-util

# GIT source
git clone --recurse-submodules https://github.com/klarna/katt-util.git
npm install
```


## Usage

### Linter

```bash
katt-lint FOLDER/FILE ...
# katt-lint -h for options
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
# katt-format -h for options
```

```coffee
kattUtil = require 'katt-util'
kattBlueprint = '...'

beautifulKattBlueprint = kattUtil.format kattBlueprint
```

### HAR-to-KATT converter

```bash
har2katt FILE ...
```

```coffee
kattUtil = require 'katt-util'
har = '...'

kattBlueprint = kattUtil.har2katt harr
```


## License

[Apache 2.0](LICENSE)


  [1]: https://travis-ci.org/klarna/katt-util
  [2]: https://travis-ci.org/klarna/katt-util.png
