defmodule RainingWeb.WeatherLive do
  @moduledoc false
  use Phoenix.LiveView
  alias Raining.Weather.Client

  # @topic "weather"
  def render(assigns) do
    ~L"""
      <div class="weather <%= @rain %>" id="weather">
        <div class="weather-inner">
          <h1> Is It Raining Right Now? </h1>
          <%= @raining %>
          <form phx-change="set-location">
            <p>Try Somewhere Else:</p>
            <select id="place-select" name="location" placeholder="Location" value="<%= @location%>"/>
              <option value="">Pick A Different City</option>
              <option value="Los Angeles">Los Angeles</option>
              <option value="Warsaw">Warsaw</option>
              <option value="Tutendo">Tutendo</option>
              <option value="Seatle">Seatle</option>
              <option value="Auckland">Auckland</option>
              <option value="Beijing">Beijing</option>
            </select>
          </form>
        </div>
      </div>
    """
  end

  def mount(_session, socket) do
    # RainingWeb.Endpoint.subscribe(@topic)
    {:ok, assign(socket, raining: "Loading...", location: "", rain: "no-rain")}
  end

  def handle_info({:put, location}, socket) do
    {:noreply, put_location(socket, location)}
  end

  defp put_location(socket, location) do
    assign(socket, location: location)
  end

  def handle_event("set-location", %{"location" => location}, socket) do
    {:ok, forecast} = Client.get_forecast(location)

    raining = Client.is_it_raining?(forecast)

    {:noreply,
     assign(socket, %{
       raining: raining_display(raining),
       location: location,
       rain: raining_class(raining)
     })}
  end

  def handle_event("set_lat_lon", %{"lat" => lat, "lon" => lon}, socket) do
    {:ok, forecast} = Client.get_forecast(lat, lon)
    raining = Client.is_it_raining?(forecast)

    {:noreply,
     assign(socket, %{
       raining: raining_display(raining),
       location: "",
       rain: raining_class(raining)
     })}
  end

  defp raining_class(true), do: "yes-rain"
  defp raining_class(false), do: "no-rain"
  defp raining_display(true), do: "YES!"
  defp raining_display(false), do: "NO!"
end
