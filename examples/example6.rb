require 'rubygems'
require File.join(File.dirname($0), "..", "lib", "chingu")
include Gosu

#
# Example of using a special GameState to fade between game states
#
# Using a simple game state, Chingu::GameStates::FadeTo, shipped with Chingu.
#
class Game < Chingu::Window
  def initialize
    super(640,800)
    switch_game_state(State1)
    self.input = {:space => :push, :return => :switch, :esc => :exit}
    self.caption = "Example of transitional game state FadeTo when switchin between two game states"
    transitional_game_state(Chingu::GameStates::FadeTo, :speed => 10)
  end
  
  def push
    #
    # Since we have a transitional game state set, the bellow code in practice become:
    #
    # if current_game_state.is_a?(State1)
    #   push_game_state(Chingu::GameStates::FadeTo.new(State2.new, :speed => 10))
    # elsif current_game_state.is_a?(State2)
    #   push_game_state(Chingu::GameStates::FadeTo.new(State1.new, :speed => 10))
    # end    
    #
    if current_game_state.is_a?(State1)
      push_game_state(State2.new)
    elsif current_game_state.is_a?(State2)
      push_game_state(State1.new)
    end
  end
  
  def switch
    if current_game_state.is_a?(State1)
      switch_game_state(State2.new)
    elsif current_game_state.is_a?(State2)
      switch_game_state(State1.new)
    end
  end
end

class State1 < Chingu::GameState
  def draw
    Image["ruby.png"].draw(0,0,0)
  end
end

class State2 < Chingu::GameState 
  def draw
    Image["video_games.png"].draw(0,0,0)
  end
end

Game.new.show

#
# The has now become premade game state shippet with Chingu.
# See chingu\game_states\fade_to.rb
#
#class FadeTo < Chingu::GameState
#  def initialize(game_state)
#    @new_game_state = game_state
#  end
#  
#  def setup
#    @color = Gosu::Color.new(0,0,0,0)
#    @alpha = 0.0
#    @fading_in = false
#  end
#  
#  def update(dt)
#    @alpha += (@fading_in ? -2 : 2)
#    if  @alpha >= 255
#      @fading_in = true 
#    else
#      @color.alpha = @alpha.to_i
#    end
#  end
#  
#  def draw
#    previous_game_state.draw  if @fading_in == false
#    @new_game_state.draw      if @fading_in == true
#    
#    $window.draw_quad(  0,0,@color,
#                        $window.width,0,@color,
#                        $window.width,$window.height,@color,
#                        0,$window.height,@color,999)
#                        
#    if @fading_in == true && @alpha == 0
#      switch_game_state(@new_game_state)
#    end
#  end  
#end
