defmodule RFC3966Test do
  use ExUnit.Case
  doctest RFC3966
  require Logger

  test "some numbers" do
    RFC3966.init

    {
      ['tel:', '+1-201-555-0123'],
      [],
      %{
        context: nil,
        descriptor: nil,
        ext: nil,
        global: true,
        isub: nil,
        local: false,
        number: '+1-201-555-0123',
        params: %{}
      }
    } = RFC3966.parse 'tel:+1-201-555-0123'

    {
      ['tel:', '7042;phone-context=example.com'],
      [],
      %{
        context: 'example.com',
        descriptor: 'example.com',
        ext: nil,
        global: false,
        isub: nil,
        local: true,
        number: '7042',
        params: %{}
      }
    } = RFC3966.parse 'tel:7042;phone-context=example.com'

    {
      ['tel:', '863-1234;phone-context=+1-914-555'],
      [],
      %{
        context: '+1-914-555',
        descriptor: '+1-914-555',
        ext: nil,
        global: false,
        isub: nil,
        local: true,
        number: '863-1234',
        params: %{}
      }
    } = RFC3966.parse 'tel:863-1234;phone-context=+1-914-555'

    {
      ['tel:', '+1-201-555-0123;param1;param2=value'],
      [],
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
    } = RFC3966.parse 'tel:+1-201-555-0123;param1;param2=value'
  end
end
