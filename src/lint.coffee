###
   Copyright 2013 Klarna AB

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
###

blueprintParser = require 'katt-blueprint-parser'
jsonlint = require 'jsonlint'
utils = require './utils'
_ = require 'lodash'


exports = module.exports = (blueprint, contentLinters = {}) ->
  result = []
  try
    scenario = blueprintParser.parse blueprint
  catch e
    result.push {
      type: 'invalid_blueprint'
      native: e
    }
    return result

  _.defaults contentLinters,
    json: exports.json

  for operation in scenario.operations
    for direction in ['request', 'response']
      reqres = operation[direction]
      headers = utils.normalizeHeaders reqres.headers
      for linterKey, linter of contentLinters
        linterResult = []
        linter reqres, operation, scenario, linterResult
        for error in linterResult
          error.operation = operation
          error.direction = direction
        result = result.concat linterResult
  result


exports.json = (reqres, operation, scenario, result) ->
  return result  unless utils.isJsonCT reqres.headers['content-type']
  content = reqres.body
  try
    # Use builtin parser for speed
    JSON.parse content
  catch e
    try
      # Use jsontlint parser for accurate error
      jsonlint.parse content
    catch e2
      result.push {
        type: 'invalid_json'
        native: e2
      }
  result
