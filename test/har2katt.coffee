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
fs = require 'fs'
har2katt = require('../').har2katt

describe 'har2katt', () ->
  it 'should work', () ->
    har = fs.readFileSync "#{__dirname}/fixtures/www.google.se.har", 'utf-8'
    apib = fs.readFileSync("#{__dirname}/fixtures/www.google.se.apib", 'utf-8').trim()
    apibIgnoreCookie = (fs.readFileSync "#{__dirname}/fixtures/www.google.se_ignoreCookie.apib", 'utf-8').trim()
    har2katt(har).should.eql apib
    har2katt(har, ['cookie']).should.eql apibIgnoreCookie

  describe '._headers', () ->
    it 'should work', () ->
      harEntryHeaders = [
        {name: 'x', value: ''},
        {name: 'z', value: ''}
      ]
      ignoreHeaders = ['x', 'y']
      har2katt._headers(harEntryHeaders, ignoreHeaders).should.eql
        z: ''
