require './lib/turn'

class Round
  attr_reader :deck, :turns, :current_card, :number_correct

  def initialize(deck)
    @deck = deck
    @turns = []
  end

  def take_turn(current_guess)
    current_turn = Turn.new(current_guess, current_card)
    @turns << current_turn
    @deck.cards.shift
    return current_turn
  end

  def current_card
    @deck.cards[0]
  end

  def number_correct
    correct_turns = @turns.find_all do |turn|
      turn.correct?
    end
    correct_turns.length
  end

  def number_correct_by_category(category)
    @turns.count do |turn|
      turn.correct? if turn.card.category == category
    end
  end

  def percent_correct
    (number_correct / @turns.count.to_f) * 100
  end

  def number_questions_per_category(category)
    @turns.count do |turn|
      turn.card.category == category
    end
  end

  def percent_correct_by_category(category)
    (number_correct_by_category(category).to_f / number_questions_per_category(category)) * 100
  end
end
