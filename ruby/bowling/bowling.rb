class Game
  class BowlingError < StandardError; end

  def roll(pins)
    self.pins = pins
    raise BowlingError if invalid_pins? || game_finished?

    score_previous_frames
    score_current_frame
  end

  def score
    raise BowlingError if game_not_finished?
    frames.sum(&:total_score)
  end

  private

  attr_accessor :pins, :current_frame
  attr_reader :frame_index

  def initialize
    @frame_index = build_frame_index
    @pins = nil
    @current_frame = frame_index[1]
  end

  def frames
    @frames ||= frame_index.values
  end

  def last_frame
    frame_index[10]
  end

  def build_frame_index
    1.upto(10).each_with_object({}) do |number, index|
      index[number] = Frame.new(number)
    end
  end

  def game_finished?
    last_frame.throws == 3 ||
      (last_frame.throws == 2 && last_frame.score < 10)
  end

  def game_not_finished?
    !game_finished?
  end

  def valid_pins?
    (0..10).include?(pins)
  end

  def invalid_pins?
    !valid_pins?
  end

  def score_previous_frames
    frames.each do |frame|
      next if frame == current_frame || frame.next_throws.zero?
      frame.next_throws_score += pins
      frame.next_throws -= 1
    end
  end

  def score_current_frame
    if last_frame?
      score_last_frame
    else
      raise BowlingError if current_frame.score + pins > 10

      record_score_and_throw!
      handle_frame_score_of_ten! if current_frame.score == 10
      set_next_frame! if current_frame.throws == 2
    end
  end

  def handle_frame_score_of_ten!
    set_next_throws!
    set_next_frame!
  end

  def set_next_throws!
    current_frame.next_throws = current_frame.throws == 1 ? 2 : 1
  end

  def score_last_frame
    if last_frame.throws == 2 &&
        (10..19).include?(last_frame.score) &&
        last_frame.score + pins > 20
      raise BowlingError
    end

    record_score_and_throw!(last_frame)
  end

  def record_score_and_throw!(frame = current_frame)
    frame.score += pins
    frame.throws += 1
  end

  def set_next_frame!
    self.current_frame = next_frame
  end

  def last_frame?
    current_frame.number == 10
  end

  def next_frame
    frame_index[current_frame.next]
  end
end

class Frame
  attr_reader :number
  attr_accessor :next_throws, :next_throws_score, :score, :throws

  def initialize(number)
    @next_throws = 0
    @next_throws_score = 0
    @number = number
    @score = 0
    @throws = 0
  end

  def total_score
    score + next_throws_score
  end

  def next
    number.next
  end
end
