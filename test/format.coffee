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
