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
defmodule RFC3966 do
  #alias RFC3966.Normalize, as: Normalize
  @moduledoc """
  A RFC3966 compatible "tel" URI parser. Find the grammar in priv/RFC3966.abnf.
  """
  @spec init() :: :ok
  def init() do
    :rfc3966 = :ets.new :rfc3966, [
      {:write_concurrency, false},
      {:read_concurrency, true},
      :public,
      :named_table
    ]
    my_priv = :code.priv_dir :ex_rfc3966
    grammar = ABNF.load_file "#{my_priv}/RFC3966.abnf"
    true = :ets.insert :rfc3966, {:grammar, grammar}
    :ok
  end

  # https://tools.ietf.org/html/rfc3966
  @spec parse([byte]) :: nil | {[byte], [byte], Map}
  def parse(text) do
    [{:grammar, grammar}] = :ets.lookup :rfc3966, :grammar
    state = %{
      global: false,
      local: false,
      number: nil,
      isub: nil,
      ext: nil,
      context: nil,
      descriptor: nil,
      params: %{}
    }
    case ABNF.apply grammar, "telephone_uri", text, state do
      nil -> nil
      {matched, rest, state} -> {matched, rest, state}
    end
  end
end
