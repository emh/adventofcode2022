defmodule Space do
    defmodule Node do
        defstruct name: nil, size: 0, parent: nil
    end

    def build_nodes([], nodes, _), do: nodes

    def build_nodes([command | rest], nodes, current_node) do
        cond do
            command == "$ cd .." -> 
                build_nodes(rest, nodes, current_node.parent)
            String.starts_with?(command, "$ cd") -> 
                node = %Node{name: Regex.run(~r/\$ cd (.*)/, command, capture: :all_but_first) |> hd, parent: current_node}
                build_nodes(rest, [node | nodes], node)
            Regex.match?(~r/^\d+ /, command) ->
                [size, name] = String.split(command)
                node = %Node{name: name, size: String.to_integer(size), parent: current_node}
                build_nodes(rest, [node | nodes], current_node)
            true -> build_nodes(rest, nodes, current_node)
        end
    end

    def build_tree(commands) do
        commands |> build_nodes([], nil)
    end

    def root(nodes), do: Enum.filter(nodes, &(&1.parent == nil)) |> hd    

    def calc_sizes(node, nodes) do
        cond do
            node.size != 0 -> node.size
            true -> Enum.filter(nodes, &(&1.parent == node)) |> Enum.map(&(calc_sizes(&1, nodes))) |> Enum.sum
        end 
    end

    def calc_sizes(nodes) do
        Enum.map(nodes, &(calc_sizes(&1, nodes))) |> Enum.zip(nodes)
    end

    def main(input) do
        input
        |> build_tree
        |> calc_sizes
        |> Enum.filter(fn ({ size, node }) -> size <= 100000 && node.size == 0 end)
        |> Enum.map(fn ({ size, _ }) -> size end)
        |> Enum.sum
        |> IO.inspect
    end
end

if !IEx.started? do
    IO.read(:stdio, :all) |> String.split("\n", trim: true) |> Space.main
end

