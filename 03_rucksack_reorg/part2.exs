defmodule Rucksack do
	def get_groups(rucksacks) do
		rucksacks
		|> Enum.map(&(to_charlist(&1)))
		|> Enum.chunk_every(3)
	end

	def overlap([rucksack1, rucksack2, rucksack3]) do
		MapSet.new(rucksack1)
		|> MapSet.intersection(MapSet.new(rucksack2))
		|> MapSet.intersection(MapSet.new(rucksack3))
		|> MapSet.to_list
	end

	def priority(item) when item >= 'a', do: hd(item) - hd('a') + 1
	def priority(item) when item >= 'A', do: hd(item) - hd('A') + 27

	def main do
		IO.read(:stdio, :all) 
		|> String.split("\n", trim: true) 
		|> get_groups
		|> Enum.map(&(overlap(&1)))
		|> Enum.map(&(priority(&1)))
		|> Enum.sum
		|> IO.inspect
	end
end

if !IEx.started? do
	Rucksack.main
end
