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
Blueprint = blueprintParser.ast.Blueprint
utils = require './utils'
lint = require './lint'
_ = require 'lodash'


exports = module.exports = (blueprint, formatters, options = {}) ->
  lintErrors = lint blueprint

  throw new Error lintError  if lintError.length

  _.defaults contentTypeFormatters,
    headers: exports.headers
    json: exports.json

  scenario = blueprintParser.parse blueprint
  for operation in scenario.operations
    for direction in ['request', 'response']
      reqres = operation[direction]
      headerFormatter = formatters.headers reqres, operation, scenario
      for formatterKey, formatter of formatters
        continue  if formatterKey is 'headers'
        formatter reqres, operation, scenario
  Blueprint.fromJSON(scenario).toBlueprint()


exports.headers = (headers) ->
  headers = utils.normalizeHeaders headers
  headers = utils.camelizeKeys headers # FIXME new module!!!
  headers = utils.sortObj headers
  headers


exports.json = (reqres, operation, scenario) ->
  return reqres.body  unless utils.isJsonCT contentType
  content = reqres.body
  contentJSON = JSON.parse content
  # Sort properties
  # FIXME
  prettyContentJSON = JSON.stringify contentJSON, null, 4
  reqres.body = prettyContentJSON
