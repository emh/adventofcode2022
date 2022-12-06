defmodule TuningTrouble do
    def different(a, a, _, _), do: false
    def different(a, _, a, _), do: false
    def different(a, _, _, a), do: false
    def different(_, a, a, _), do: false
    def different(_, a, _, a), do: false
    def different(_, _, a, a), do: false
    def different(_, _, _, _), do: true

    def scan([a, b, c, d | rest], position) do
        cond do
            different(a, b, c, d) ->
                position
            true ->
                scan([b, c, d | rest], position + 1)
        end
    end

    def scan(_, _), do: -1

    def scan(input) do
        scan(input, 4)
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

