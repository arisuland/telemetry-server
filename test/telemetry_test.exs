defmodule Arisu.TelemetryTest do
  use ExUnit.Case
  doctest Arisu.Telemetry

  test "greets the world" do
    assert Arisu.Telemetry.hello() == :world
  end
end
