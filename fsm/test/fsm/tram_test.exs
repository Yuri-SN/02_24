defmodule Fsm.TramTest do
  use ExUnit.Case

  alias Fsm.Tram

  describe "initial cases" do
    test "test initial state" do
      Fsm.Tram.start_link("47a")

      initial_state = Fsm.Tram.status()

      assert initial_state.status == :idle
      assert initial_state.tram_num == "47a"
      assert initial_state.doors_opened == false
      assert initial_state.passengers == 0
    end
  end

  describe "from :idle state" do
    test ":start command" do
      Fsm.Tram.start_link("47a")
      message = Fsm.Tram.send_command(:start)

      assert message == "tram 47a started moving"

      state = Fsm.Tram.status()

      assert state.status == :moving
      assert state.doors_opened == false
      assert state.passengers == 0
    end
  end

  describe "from :moving state" do
    test ":start command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command(:start)

      assert message == "tram 47a already moving"

      state = Fsm.Tram.status()

      assert state.doors_opened == false
    end

    test ":stop command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command(:stop)

      assert message == "tram 47a stopped"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.doors_opened == true
      assert state.passengers == 0
    end

    test ":change_passengers command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command({:change_passengers, Enum.random(1..Tram.max_passengers())})

      assert message == "can't change passengers: tram moving"

      state = Fsm.Tram.status()

      assert state.status == :moving
      assert state.doors_opened == false
    end

    test ":empty_tram command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      Fsm.Tram.send_command(:change_passengers)
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command(:empty_tram)

      assert message == "can't empty tram: tram is moving"

      state = Fsm.Tram.status()

      assert state.status == :moving
      assert state.doors_opened == false
    end

    test ":to_depot command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command(:to_depot)

      assert message == "can't move to depot: on route"

      state = Fsm.Tram.status()

      assert state.status == :moving
    end
  end

  describe "from :stopped state" do
    test ":stop command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)

      message = Fsm.Tram.send_command(:stop)

      assert message == "tram 47a already stopped"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.doors_opened == true
      assert state.passengers == 0
    end

    test ":change_passengers command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)

      passengers = Enum.random(1..Tram.max_passengers())

      message = Fsm.Tram.send_command({:change_passengers, passengers})

      assert message == "passengers changed"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.doors_opened == true
      assert state.passengers == passengers
    end

    test ":empty_tram command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      Fsm.Tram.send_command(:change_passengers)
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)

      message = Fsm.Tram.send_command(:empty_tram)

      assert message == "tram is empty"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.doors_opened == true
      assert state.passengers == 0
    end

    test ":to_depot command without passengers" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      Fsm.Tram.send_command(:change_passengers)
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      Fsm.Tram.send_command(:empty_tram)

      message = Fsm.Tram.send_command(:to_depot)

      assert message == "moving to depot and stop"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.doors_opened == false
      assert state.passengers == 0
    end

    test ":to_depot command with passengers" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      Fsm.Tram.send_command({:change_passengers, 5})
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)

      message = Fsm.Tram.send_command(:to_depot)

      assert message == "can't move to depot: tram is not empty"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.doors_opened == true
      assert state.passengers > 0
    end
  end

  describe "from :at_depot state" do
    test ":to_depot command" do
      Fsm.Tram.start_link("47a")

      message = Fsm.Tram.send_command(:to_depot)

      assert message == "already in depot"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.doors_opened == false
      assert state.passengers == 0
    end

    test ":change_passengers command" do
      Fsm.Tram.start_link("47a")

      message = Fsm.Tram.send_command({:change_passengers, 5})

      assert message == "can't change passengers: tram in depot"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.doors_opened == false
      assert state.passengers == 0
    end

    test ":stop command" do
      Fsm.Tram.start_link("47a")

      message = Fsm.Tram.send_command(:stop)

      assert message == "can't stop: tram in depot"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.doors_opened == false
      assert state.passengers == 0
    end
  end

  describe "invalid commands" do
    test "from :idle send :invalid command" do
      Fsm.Tram.start_link("47a")

      message = Fsm.Tram.send_command(:invalid)

      assert message == "command not allowed"

      state = Fsm.Tram.status()

      assert state.status == :idle
    end
  end
end
