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
