var foo = require('foo')
var assert = require('assert')

describe('Foo', () => {
    describe('the module', () => {
        it('should have bar defined', () => {
            assert.equal(foo.bar, "bar!")
        })
    })
})