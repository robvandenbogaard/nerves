defmodule AppNoEnv.Fixture do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :app_no_env,
     version: "0.1.0",
     target: @target,
     deps: deps()]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:system, path: "../system"}]
  end

end
