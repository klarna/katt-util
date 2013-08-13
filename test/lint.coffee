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
lint = require('../').lint

describe 'lint', () ->
  it 'should return one error of type invalid_blueprint', () ->
    lint('')[0].type.should.eql 'invalid_blueprint'


  describe 'json', () ->
    it 'should return one error of type invalid_json', () ->
      reqres = {headers:{'content-type':'application/json'}, body:''}
      lint.json(reqres, null, null, [])[0].type.should.eql 'invalid_json'

    it 'should ignore non-JSON Content-Types', () ->
      reqres = {headers:{'content-type':'application/xml'}, body:''}
      lint.json(reqres, null, null, []).should.eql []

    it 'should return no error on valid JSON', () ->
      reqres = {headers:{'content-type':'application/json'}, body:'{}'}
      lint.json(reqres, null, null, []).should.eql []
