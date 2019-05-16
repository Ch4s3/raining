defmodule Raining.Weather.Client do
  @moduledoc """
  A wrapper around `Darkskyx` with some data access on top
  """

  @type status_code :: integer
  @type response ::
          {:ok, struct} | {:error, map, status_code} | {:error, map}

  @doc """
  Latitude and Longitude based get function
  """
  @spec get_forecast(integer(), integer()) :: response()
  def get_forecast(lat, lng) do
    Darkskyx.forecast(lat, lng, %Darkskyx{exclude: "daily,hourly, minutely"})
  end

  def get_forecast(name_of_city) do
    %{lat: lat, lng: lng} = get_city_lat_lng(name_of_city)
    Darkskyx.forecast(lat, lng, %Darkskyx{exclude: "daily,hourly, minutely"})
  end

  @spec is_it_raining?(struct()) :: true | false
  def is_it_raining?(forecast) do
    forecast["currently"]["precipType"] == "rain"
  end

  def get_city_lat_lng("Los Angeles"), do: %{lat: 34.0201613, lng: -118.6919124}
  def get_city_lat_lng("Warsaw"), do: %{lat: 52.232855, lng: 20.9211111}
  def get_city_lat_lng("Tutendo"), do: %{lat: 5.7446055, lng: -76.5443794}
  def get_city_lat_lng("Seatle"), do: %{lat: 47.6129432, lng: -122.4821483}
  def get_city_lat_lng("Auckland"), do: %{lat: 36.8626942, lng: 174.585279}
  def get_city_lat_lng("Beijing"), do: %{lat: 39.9385466, lng: 116.1172704}
  def get_city_lat_lng(_), do: %{lat: 0, lng: 0}
end
