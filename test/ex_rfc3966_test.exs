################################################################################
# Copyright 2015 Marcelo Gornstein <marcelog@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################
defmodule RFC3966Test do
  use ExUnit.Case, async: true
  doctest RFC3966
  require Logger

  @on_load :init

  def init do
    me = self()
    spawn fn ->
      RFC3966.init
      send me, :done
      receive do
        _ -> :ok
      end
    end
    receive do
      :done -> :ok
    end
    :ok
  end

  test "some numbers" do
    {
      'tel:+1-201-555-0123',
      [],
      %RFC3966.Result{
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
      'tel:7042;phone-context=example.com',
      [],
      %RFC3966.Result{
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
      'tel:863-1234;phone-context=+1-914-555',
      [],
      %RFC3966.Result{
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
      'tel:+1-201-555-0123;param1;param2=value',
      [],
      %RFC3966.Result{
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
