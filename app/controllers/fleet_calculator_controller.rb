require './lib/carry_calculator/carry_calculator'

class FleetCalculatorController < ApplicationController
  before_action :set_calculator, :fleet_calculator_params, only: [:weight_calculate]

  def weight_calculate
    @weight = fleet_calculator_params.to_i
    @result = @calculator.get_manifest(@weight)
    render 'results'
  end

  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_calculator
    key = Ship.all.collect(&:ship_capacity).sort.to_s
    @calculator = Rails.cache.fetch(key.to_s) { create_calculator }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fleet_calculator_params
    params.require(:total_weight)
  end

  def create_calculator
    calc = CarryCalculator.new
    Ship.all.each do |ship|
      calc.add_container(ship.ship_name, ship.ship_capacity)
    end
    calc.preprocess
    calc
  end
end
