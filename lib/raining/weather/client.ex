defmodule Raining.Weather.Client do
  @moduledoc """
  A wrapper around `Darkskyx` with some data access on top
  """

  @type status_code :: integer
  @type response :: {:ok, [struct]} | {:ok, struct} | :ok | {:error, map, status_code} | {:error, map}

  @doc """
  Latitude and Longitude based get function
  """
  @spec get_forecast(integer(), integer()) :: response()
  def get_forecast(lat, lng) do
    Darkskyx.forecast(lat, lng, %Darkskyx{exclude: "daily,hourly, minutely"})
  end
end
