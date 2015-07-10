[![Build Status](https://travis-ci.org/marcelog/ex_rfc3966.svg)](https://travis-ci.org/marcelog/ex_rfc3966)
RFC3966
=======

A Tel URI parser trying to be strictly compatible with [RFC3966](https://tools.ietf.org/html/rfc3966).

This project uses [ex_abnf](https://github.com/marcelog/ex_abnf) with the official [uri grammar](https://github.com/marcelog/ex_rfc3966/blob/master/priv/RFC3966.abnf)

## Example

    iex> RFC3966.init # Call this one first to initialize the grammar.
    iex> {['tel:', _matched_tel], _not_matched_input, result} = RFC3966.parse 'tel:+1-201-555-0123;param1;param2=value'
    iex> result
    %{
        context: nil,
        descriptor: nil,
        ext: nil,
        global: true,
        isub: nil,
        local: false,
        number: '+1-201-555-0123',
        params: %{'param1' => nil, 'param2' => 'value'}
    }


## Using it with Mix

To use it in your Mix projects, first add it as a dependency:

```elixir
def deps do
  [{:ex_rfc3966, "~> 0.1.0"}]
end
```
Then run mix deps.get to install it.

## License
The source code is released under Apache 2 License.

Check [LICENSE](https://github.com/marcelog/ex_abnf/blob/master/LICENSE) file for more information.
