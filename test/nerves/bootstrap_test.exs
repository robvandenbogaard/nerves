defmodule Nerves.BootstrapTest do
  use NervesTest.Case, async: false
  import ExUnit.CaptureIO

  test "list Nerves packages from env info" do
    in_fixture "simple_app", fn ->
      packages =
        ~w(system toolchain system_platform toolchain_platform)

      env_pkgs = load_env(packages)

      Nerves.Env.system.path
      |> File.mkdir_p!

      Nerves.Env.toolchain.path
      |> File.mkdir_p!

      System.put_env("NERVES_SYSTEM", Nerves.Env.system.path)
      System.put_env("NERVES_TOOLCHAIN", Nerves.Env.toolchain.path)

      Mix.Task.run "deps.compile", []
      Mix.Tasks.Nerves.Env.run(["--info"])
      assert_received({:mix_shell, :info, ""})
      System.delete_env("NERVES_SYSTEM")
      System.delete_env("NERVES_TOOLCHAIN")
    end
  end
end
