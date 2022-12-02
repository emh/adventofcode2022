#!/usr/bin/env elixir

IO.read(:stdio, :all) 
	|> String.split("\n") 
	|> Enum.map(&(if &1 == "", do: 0, else: String.to_integer(&1))) 
	|> Enum.chunk_by(&(&1 == 0)) 
	|> Enum.map(&(Enum.sum(&1))) 
	|> Enum.sort 
	|> Enum.slice(-3, 3) 
	|> Enum.sum
	|> IO.inspect

