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
kattFormat = require('../').format
pkg = require '../package'


# For argument validation / transformation.
CUSTOM_TYPES =
  module: (value) ->
    if fs.existsSync value
      require value
    else
      throw new Error "Invalid module: #{value}."

parseArgs = (args) ->
  ArgumentParser = argparse.ArgumentParser

  parser = new ArgumentParser
    description: pkg.description
    version: pkg.version
    addHelp: true

  parser.addArgument ['-l', '--formatters'],
    help: "Module that exports formatter extensions. (%(defaultValue)s)"
    defaultValue: undefined
    type: CUSTOM_TYPES.module

  parser.addArgument ['scenarios'],
    help: 'Scenarios as files/folders'
    nargs: '+'

  parser.parseArgs args


main = exports.main = (args = process.args) ->
  args = parseArgs args
  exitCode = 0
  for filename in args.scenarios
    process.stdout.write "~ #{filename}"
    blueprint = fs.readFileSync filename, 'utf-8'
    blueprint = kattFormat blueprint, args.formatters
    fs.writeFileSync filename, blueprint, 'utf-8'
    console.log "\r✔ #{filename}"
  return exitCode

process.exit main()  if require.main is module
