defmodule Rucksack do
	def split(contents) do
		contents 
		|> String.split_at(div(String.length(contents), 2)) 
		|> (&({to_charlist(elem(&1, 0)), to_charlist(elem(&1, 1))})).()
	end

	def overlap({compartment1, compartment2}) do
		MapSet.intersection(MapSet.new(compartment1), MapSet.new(compartment2))
		|> MapSet.to_list
	end

	def priority(item) when item >= 'a', do: hd(item) - hd('a') + 1
	def priority(item) when item >= 'A', do: hd(item) - hd('A') + 27

	def check(rucksack) do
		rucksack
		|> split
		|> overlap
		|> priority
	end

	def main do
		IO.read(:stdio, :all) 
		|> String.split("\n", trim: true) 
		|> Enum.map(&(check(&1)))
		|> Enum.sum
		|> IO.inspect
	end
end

if !IEx.started? do
	Rucksack.main
end
