defmodule Cleanup do
    def parse(line) do
        line
        |> String.split([",", "-"])
        |> Enum.map(&(String.to_integer(&1)))
        |> List.to_tuple
        |> (&({Range.new(elem(&1, 0), elem(&1, 1)), Range.new(elem(&1, 2), elem(&1, 3))})).()
    end

    def overlap?({sections1, sections2}), do: if Range.disjoint?(sections1, sections2), do: 0, else: 1

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

