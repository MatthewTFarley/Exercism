# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  use Agent

  defstruct next_plot_id: 1, plots: []

  def start(_opts \\ []) do
    Agent.start(fn -> %CommunityGarden{} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.update(pid, fn state ->
      %CommunityGarden{
        state
        | next_plot_id: state.next_plot_id + 1,
          plots: [
            %Plot{
              plot_id: state.next_plot_id,
              registered_to: register_to
            }
            | state.plots
          ]
      }
    end)

    Agent.get(pid, fn state -> hd(state.plots) end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %CommunityGarden{
        state
        | plots: Enum.filter(state.plots, fn plot -> plot.plot_id != plot_id end)
      }
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(state.plots, &(&1.plot_id == plot_id))
    end)
    |> case do
      nil -> {:not_found, "plot is unregistered"}
      plot -> plot
    end
  end
end
