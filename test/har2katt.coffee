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
