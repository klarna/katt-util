#!/usr/bin/env coffee
# Copyright 2013 Klarna AB
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

fs = require 'fs'
argparse = require 'argparse'
_ = require 'lodash'
har2katt = require('../').har2katt
pkg = require '../package'


# For argument validation / transformation.
parseArgs = (args) ->
  ArgumentParser = argparse.ArgumentParser

  parser = new ArgumentParser
    description: pkg.description
    version: pkg.version
    addHelp: true

  parser.addArgument ['archives'],
    help: 'Archives as files'
    nargs: '+'

  parser.parseArgs args


main = (args = process.args) ->
  args = parseArgs args
  for filename in args.archives
    har = fs.readFileSync filename, 'utf-8'
    blueprint = har2katt har
    console.log blueprint

process.exit main()  if require.main is module
