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

_ = require 'lodash'

exports.sortObj = (obj) ->
  result = {}
  keys = Object.keys(obj).sort()
  for key in keys
    result[key] = obj[key]
    result[key] = exports.sortObj obj[key]  if _.isPlainObject obj[key]
  result


exports.isJsonCT = (contentType) ->
  /\bjson\b/.test contentType


exports.normalizeHeaders = (headers) ->
  result = {}
  for name, value of headers
    name = name.trim().toLowerCase()
    result[name] = value
  result
