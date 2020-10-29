defmodule RobotSimulator do
  defguard valid_direction?(dir)
           when is_atom(dir) and
                  dir in [:north, :south, :east, :west]

  defguard valid_position?(pos)
           when is_tuple(pos) and
                  tuple_size(pos) == 2 and
                  is_integer(elem(pos, 0)) and
                  is_integer(elem(pos, 1))

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, position)
      when valid_direction?(direction) and valid_position?(position),
      do: {direction, position}

  def create(direction, _position)
      when not valid_direction?(direction),
      do: {:error, "invalid direction"}

  def create(_direction, position)
      when not valid_position?(position),
      do: {:error, "invalid position"}

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

  defp move(robot, ?R), do: turn_right(robot)
  defp move(robot, ?L), do: turn_left(robot)
  defp move(robot, ?A), do: advance(robot)

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
