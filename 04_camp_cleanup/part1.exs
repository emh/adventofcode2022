defmodule Cleanup do
    def parse(line) do
        line
        |> String.split([",", "-"])
        |> Enum.map(&(String.to_integer(&1)))
        |> List.to_tuple
        |> (&({Range.new(elem(&1, 0), elem(&1, 1)), Range.new(elem(&1, 2), elem(&1, 3))})).()
    end

    def overlap?({sections1, sections2}) when sections1.first <= sections2.first and sections1.last >= sections2.last, do: 1
    def overlap?({sections1, sections2}) when sections2.first <= sections1.first and sections2.last >= sections1.last, do: 1
    def overlap?({_, _}), do: 0

    def main do
        IO.read(:stdio, :all) 
        |> String.split("\n", trim: true) 
        |> Enum.map(&(parse(&1)))
        |> Enum.map(&(overlap?(&1)))
        |> Enum.sum
        |> IO.inspect
    end
end

if !IEx.started? do
    Cleanup.main
end

