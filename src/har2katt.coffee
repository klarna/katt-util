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
_ = require 'lodash'
lint = require './lint'


exports = module.exports = (har) ->
  har = JSON.parse har
  blueprint =
    transactions: []
  for entry in har.log.entries
    req = entry.request
    res = entry.response
    transaction =
      request:
        method: req.method
        url: req.url.replace /[^\/]+\/\/[^\/]+/, ''
        headers: exports._headers req.headers
        body: req.postData?.text or null
      response:
        status: res.status
        headers: exports._headers res.headers
        body: res.content?.text or null
    blueprint.transactions.push transaction
  Blueprint.fromJSON(blueprint).toBlueprint()


exports._headers = (harEntryHeaders) ->
  harEntryHeaders = _.reject harEntryHeaders, (header) ->
    header.name.toLowerCase() in [
      'accept-encoding'
      'cache-control'
      'connection'
      'content-encoding'
      'content-length'
      'date'
      'host'
      'last-modified'
      'pragma'
    ]
  _.object _.pluck(harEntryHeaders, 'name'), _.pluck(harEntryHeaders, 'value')
