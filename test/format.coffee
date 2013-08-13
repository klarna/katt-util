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

{
  should
} = require './_utils'
format = require('../').format

describe 'format', () ->


  describe '.normalizeHeaders', () ->
    it 'should lowercase headers', () ->
      reqres = {headers: {'Accept': '', 'Content-TyPe': ''}}
      format.normalizeHeaders(reqres).should.eql
        'accept': ''
        'content-type': ''


  describe '.headers', () ->
    it 'should camelize headers', () ->
      reqres = {headers: {'accept': '', 'content-TyPe': ''}}
      format.headers(reqres).should.eql
        'Accept': ''
        'Content-Type': ''

    it 'should sort headers', () ->
      reqres = {headers: {'Content-Type': '', 'Accept': ''}}
      format.headers(reqres).should.eql
        'Accept': ''
        'Content-Type': ''


  describe '.json', () ->
    it 'should ignore non-JSON Content-Types', () ->
      reqres = {headers: {'content-type':'application/xml'}, body:''}
      format.json(reqres, null, null, []).should.eql ''

    it 'should return no error on valid JSON', () ->
      reqres = {headers:{'content-type':'application/json'}, body:'{}'}
      format.json(reqres, null, null, []).should.eql '{}'

    it 'should sort object properties', () ->
      reqres = {headers:{'content-type':'application/json'}, body:'{"foo":true,"bar":true}'}
      format.json(reqres, null, null, []).should.eql '{\n    "bar": true,\n    "foo": true\n}'
