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

exports.sortObj = (obj) ->
  result = {}
  keys = Object.keys(obj).sort()
  result[key] = obj[key]  for key in keys
  result


exports.camelize = (s) ->
  s = s.trim()
  s = s.replace /[-_\s]+(.)?/g, (match, c) -> '-' + c.toUpperCase()
  s = s.charAt(0).toUpperCase() + s.slice 1
  s


exports.camelizeKeys = (obj) ->
  result = {}
  keys = Object.keys obj
  for key, index in keys
    header = exports.camelize key
    result[header] = obj[key]
  result


exports.isJsonCT = (contentType) ->
  /\bjson\b/.test contentType


exports.normalizeHeaders = (headers) ->
  result = {}
  for name, value of headers
    # Lowercase names
    # since headers are case-insensitive
    name = name.trim().toLowerCase()
    result[name] = value
  result
