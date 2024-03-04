defmodule Fsm.TramTest do
  use ExUnit.Case

  describe "valid cases" do
    test "test initial state" do
      Fsm.Tram.start_link("47a")

      initial_state = Fsm.Tram.status()

      assert initial_state.status == :idle
      assert initial_state.tram_num == "47a"
      assert initial_state.passengers == 0
      assert initial_state.doors_opened == false
    end

    test "test start command" do
      Fsm.Tram.start_link("47a")
      message = Fsm.Tram.send_command(:start)

      assert message == "tram 47a started moving"

      state = Fsm.Tram.status()

      assert state.status == :moving
      assert state.tram_num == "47a"
      assert state.passengers == 0
      assert state.doors_opened == false
    end

    test "command stop while moving" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command(:stop)

      assert message == "tram 47a stopped"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.passengers == 0
      assert state.doors_opened == true
    end

    test "change_passengers command" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      message = Fsm.Tram.send_command(:change_passengers)

      assert message == "passengers changed"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.doors_opened == true
    end

    test "command :empty_tram" do
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
      assert state.passengers == 0
      assert state.doors_opened == true
    end

    test "move tram to depot" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      Fsm.Tram.send_command(:change_passengers)
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)
      Fsm.Tram.send_command(:empty_tram)

      message = Fsm.Tram.send_command(:at_depot)

      assert message == "moving to depot"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.doors_opened == false
      assert state.passengers == 0
    end
  end

  describe "invalid cases" do
    test "command start while moving" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command(:start)

      assert message == "tram 47a already moving"

      state = Fsm.Tram.status()

      assert state.doors_opened == false
    end

    test "command stop while stopped" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)
      Fsm.Tram.send_command(:stop)

      message = Fsm.Tram.send_command(:stop)

      assert message == "tram 47a already stopped"

      state = Fsm.Tram.status()

      assert state.status == :stopped
      assert state.passengers == 0
      assert state.doors_opened == true
    end

    test "try change passengers while moving" do
      Fsm.Tram.start_link("47a")
      Fsm.Tram.send_command(:start)

      message = Fsm.Tram.send_command(:change_passengers)

      assert message == "can't change passengers: tram moving"

      state = Fsm.Tram.status()

      assert state.status == :moving
      assert state.doors_opened == false
    end

    test "try empty tram while moving" do
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

    test "try move to depot while already in depot" do
      Fsm.Tram.start_link("47a")

      message = Fsm.Tram.send_command(:at_depot)

      assert message == "already in depot"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.passengers == 0
      assert state.doors_opened == false
    end

    test "try to change passengers while in depot" do
      Fsm.Tram.start_link("47a")

      message = Fsm.Tram.send_command(:change_passengers)

      assert message == "can't change passengers: tram in depot"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.passengers == 0
      assert state.doors_opened == false
    end

    test "try to stop while in depot" do
      Fsm.Tram.start_link("47a")

      message = Fsm.Tram.send_command(:stop)

      assert message == "can't stop: tram in depot"

      state = Fsm.Tram.status()

      assert state.status == :idle
      assert state.passengers == 0
      assert state.doors_opened == false
    end
  end
end
