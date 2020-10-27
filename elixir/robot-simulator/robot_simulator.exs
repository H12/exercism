defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      not valid_direction?(direction) -> {:error, "invalid direction"}
      not valid_position?(position) -> {:error, "invalid position"}
      true -> {direction, position}
    end
  end

  defp valid_direction?(dir) do
    is_atom(dir) and
      Enum.member?([:north, :south, :east, :west], dir)
  end

  defp valid_position?(pos) do
    is_tuple(pos) and
      tuple_size(pos) == 2 and
      Enum.all?(Tuple.to_list(pos), &is_integer(&1))
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    with instruction_list <- String.to_charlist(instructions),
         true <- Enum.all?(instruction_list, &valid_instruction?/1) do
      instruction_list
      |> Enum.map_reduce(robot, fn i, robot -> {i, move(robot, i)} end)
      |> elem(1)
    else
      _err -> {:error, "invalid instruction"}
    end
  end

  defp valid_instruction?(instruction), do: Enum.member?('RLA', instruction)

  @doc """
  Takes a robot and an integer representing a codepoint for either the
  letter "R" (82), "L" (76), or "A", (65).
  """
  def move(robot, codepoint)

  def move(robot, 82), do: turn_right(robot)
  def move(robot, 76), do: turn_left(robot)
  def move(robot, 65), do: advance(robot)

  defp turn_right({:north, pos}), do: {:east, pos}
  defp turn_right({:east, pos}), do: {:south, pos}
  defp turn_right({:south, pos}), do: {:west, pos}
  defp turn_right({:west, pos}), do: {:north, pos}

  defp turn_left({:north, pos}), do: {:west, pos}
  defp turn_left({:west, pos}), do: {:south, pos}
  defp turn_left({:south, pos}), do: {:east, pos}
  defp turn_left({:east, pos}), do: {:north, pos}

  defp advance({:north, {x, y}}), do: {:north, {x, y + 1}}
  defp advance({:east, {x, y}}), do: {:east, {x + 1, y}}
  defp advance({:south, {x, y}}), do: {:south, {x, y - 1}}
  defp advance({:west, {x, y}}), do: {:west, {x - 1, y}}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _position}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_direction, position}) do
    position
  end
end
