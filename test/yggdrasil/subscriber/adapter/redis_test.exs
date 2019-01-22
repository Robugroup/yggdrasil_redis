defmodule Yggdrasil.Subscriber.Adapter.RedisTest do
  use ExUnit.Case, async: true

  alias Yggdrasil.Backend
  alias Yggdrasil.Channel
  alias Yggdrasil.Registry
  alias Yggdrasil.Settings
  alias Yggdrasil.Subscriber.Adapter
  alias Yggdrasil.Subscriber.Adapter.Redis
  alias Yggdrasil.Subscriber.Manager
  alias Yggdrasil.Subscriber.Publisher

  @registry Settings.yggdrasil_process_registry!()

  test "distribute message" do
    name = UUID.uuid4()
    channel = %Channel{name: name, adapter: :redis, namespace: RedisTest}
    {:ok, channel} = Registry.get_full_channel(channel)
    Backend.subscribe(channel)
    publisher = {:via, @registry, {Publisher, channel}}
    manager = {:via, @registry, {Manager, channel}}
    assert {:ok, _} = Publisher.start_link(channel, name: publisher)
    assert {:ok, _} = Manager.start_link(channel, name: manager)
    :ok = Manager.add(channel, self())

    assert {:ok, adapter} = Adapter.start_link(channel)
    assert_receive {:Y_CONNECTED, ^channel}, 500

    options = Redis.redis_options(channel)
    {:ok, conn} = Redix.start_link(options)
    {:ok, 1} = Redix.command(conn, ~w(PUBLISH #{name} #{"message"}))
    Redix.stop(conn)

    assert_receive {:Y_EVENT, ^channel, "message"}, 500

    assert :ok = Adapter.stop(adapter)
    assert_receive {:Y_DISCONNECTED, ^channel}, 500
  end
end
