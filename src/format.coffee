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
camelizeHeaders = require 'camelize-http-headers'


exports = module.exports = (blueprint, formatters, options = {}) ->
  lintErrors = lint blueprint

  throw new Error lintError  if lintError.length

  _.defaults contentTypeFormatters,
    json: exports.json

  scenario = blueprintParser.parse blueprint
  for transaction in scenario.transactions
    for direction in ['request', 'response']
      reqres = transaction[direction]
      formatters.normalizeHeaders reqres, transaction, scenario
      for formatterKey, formatter of formatters
        formatter reqres, transaction, scenario
      formatters.headers reqres, transaction, scenario
  Blueprint.fromJSON(scenario).toBlueprint()


exports.normalizeHeaders = (reqres, transaction, scenario) ->
  reqres.headers = utils.normalizeHeaders reqres.headers


exports.headers = (reqres, transaction, scenario) ->
  headers = reqres.headers
  headers = camelizeHeaders headers
  headers = utils.sortObj headers
  reqres.headers = headers


exports.json = (reqres, transaction, scenario) ->
  return reqres.body  unless utils.isJsonCT reqres.headers['content-type']
  content = reqres.body
  contentJSON = JSON.parse content
  contentJSON = utils.sortObj contentJSON
  prettyContentJSON = JSON.stringify contentJSON, null, 4
  reqres.body = prettyContentJSON
