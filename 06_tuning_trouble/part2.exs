defmodule TuningTrouble do
    def different(input) do
        14 == input |> MapSet.new |> MapSet.size
    end

    def scan(input, position) do
        {chunk, rest} = Enum.split(input, 14)

        cond do
            different(chunk) ->
                position
            true ->
                scan(tl(chunk) ++ rest, position + 1)
        end
    end

    def scan(input) do
        scan(input, 14)
    end

    def main() do
        IO.read(:stdio, :all)
        |> to_charlist
        |> scan
        |> IO.inspect
    end
end

if !IEx.started? do
    TuningTrouble.main
end

