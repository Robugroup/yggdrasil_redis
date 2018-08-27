defmodule YggdrasilRedis.MixProject do
  use Mix.Project

  @version "4.0.0"

  def project do
    [
      app: :yggdrasil_redis,
      version: @version,
      elixir: "~> 1.6",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Yggdrasil.Redis.Application, []}
    ]
  end

  defp deps do
    [
      {:yggdrasil, git: "https://github.com/gmtprime/yggdrasil.git", branch: "4.0.0"},
      {:redix_pubsub, "~> 0.4"},
      {:uuid, "~> 1.1", only: [:dev, :test]},
      {:ex_doc, "~> 0.18.4", only: :dev},
      {:credo, "~> 0.9", only: :dev}
    ]
  end

  defp docs do
    [source_url: "https://github.com/gmtprime/yggdrasil_redis",
     source_ref: "v#{@version}",
     main: Yggdrasil.Redis.Application]
  end

  defp description do
    """
    Redis adapter for Yggdrasil.
    """
  end

  defp package do
    [maintainers: ["Alexander de Sousa"],
     licenses: ["MIT"],
     links: %{"Github" => "https://github.com/gmtprime/yggdrasil_redis"}]
  end
end
