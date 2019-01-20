defmodule Yggdrasil.Settings.Redis do
  @moduledoc """
  This module defines the available settings for Redis in Yggdrasil.
  """
  use Skogsra

  #######################################################
  # Redis connection default variables for default domain

  @envdoc """
  Redis hostname. Defaults to `"localhost"`.
  """
  app_env :yggdrasil_redis_hostname, :yggdrasil, [:redis, :hostname],
    default: "localhost"

  @envdoc """
  Redis port. Defaults to `6379`.
  """
  app_env :yggdrasil_redis_port, :yggdrasil, [:redis, :port], default: 6379

  @envdoc """
  Redis password. Defaults to `nil`.
  """
  app_env :yggdrasil_redis_password, :yggdrasil, [:redis, :password]

  @envdoc """
  Redis database. Defaults to `0`.
  """
  app_env :yggdrasil_redis_database, :yggdrasil, [:redis, :database], default: 0
end
