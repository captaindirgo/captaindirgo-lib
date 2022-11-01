import * as t from '../../src/types.js'

test('make sure pubkey can\'t be mistaken for privkey', () => {
    //typescript test, just by compiling, we test it
    let pubKey = "...pubkey..." as t.PubKey
    let privKey = "...privkey..." as t.PrivKey

    function foo(pk : t.PubKey) {
    }

    function foo2(pk : t.PrivKey) {
    }

    foo(pubKey)

    // make sure a private key can't be used in place of a public one
    // @ts-expect-error
    foo(privKey)

    // or a string
    // @ts-expect-error
    foo("foo")

    // make sure a pub key can't be used in place of a private one
    // @ts-expect-error
    foo2(pubKey)
    foo2(privKey)
})