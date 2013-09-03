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
kattLint = require('../').lint
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

  parser.addArgument ['-l', '--linters'],
    help: "Module that exports linter extensions. (%(defaultValue)s)"
    defaultValue: undefined
    type: CUSTOM_TYPES.module

  parser.addArgument ['scenarios'],
    help: 'Scenarios as files/folders'
    nargs: '+'

  parser.parseArgs args


main = (args = process.args) ->
  args = parseArgs args
  exitCode = 0
  for filename in args.scenarios
    process.stdout.write "~ #{filename}"
    blueprint = fs.readFileSync filename, 'utf-8'
    errors = kattLint blueprint, args.linters
    sign = '✔'
    sign = '✘'  if errors.length
    console.log "\r#{sign} #{filename}"
    if errors.length
      exitCode = 1
      for error in errors
        details = []
        details.push error.details.transaction.name  if error.details?.transaction
        details.push error.details.transaction.direction  if error.details?.transaction
        details = details.join ' '
        console.log "#{error.type} #{details}", error.native
  return exitCode

process.exit main()  if require.main is module
