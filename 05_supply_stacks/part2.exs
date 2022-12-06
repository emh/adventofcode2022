defmodule SupplyStacks do
    def parse_input(input) do
        input
        |> String.split("\n", trim: true)
    end

    def parse_stacks(lines) do
        lines
        |> Enum.map(&(to_charlist(&1)))
        |> List.zip 
        |> Enum.filter(&(elem(&1, tuple_size(&1)-1) >= hd('1'))) 
        |> Enum.map(&Tuple.to_list/1)
        |> Enum.map(&(Enum.filter(&1, fn(ch) -> ch >= hd('A') && ch <= hd('Z') end)))
    end

    def parse_instructions(lines) do
        lines
        |> Enum.map(&(Regex.run(~r/move (\d+) from (\d+) to (\d+)/, &1, capture: :all_but_first)))
        |> Enum.map(&(Enum.map(&1, fn(n) -> String.to_integer(n) end))) 
        |> Enum.map(&List.to_tuple/1)
    end

    def execute([], stacks), do: stacks

    def execute([instruction | rest], stacks) do
        execute(rest, execute(instruction, stacks))    
    end    

    def execute({n, from, to}, stacks) do
        from_stack = Enum.at(stacks, from - 1)
        to_stack = Enum.at(stacks, to - 1)

        {crates, from_stack} = from_stack |> Enum.split(n)

        stacks
        |> List.replace_at(from-1, from_stack)
        |> List.replace_at(to-1, crates ++ to_stack)
    end

    def tops(stacks) do
        stacks 
        |> Enum.map(&hd/1)
    end

    def exec(input) do
        lines = parse_input(input)

        [stack_lines, instruction_lines] = Enum.chunk_by(lines, &(String.starts_with?(&1, "move")))

        stacks = parse_stacks(stack_lines)
        instructions = parse_instructions(instruction_lines)

        stacks = execute(instructions, stacks)

        tops(stacks)
    end

    def main() do
        IO.read(:stdio, :all)
        |> exec
        |> IO.inspect
    end
end

if !IEx.started? do
    SupplyStacks.main
end

