require 'faker'

FactoryBot.define do
  factory :card do
    before :create do |card|
      num = Faker::Number.between(1, 5)
      periods = Period.where(period: num)
      card.period = periods.first || create(:period, period: num)
      print "period: #{card.period.name}\n"

      num = Faker::Number.between(1, 6)
      daysdefs = Daysdef.where(days: CardsRepositoryHelper.number_as_string(num.to_i, :days))
      card.days = daysdefs.first.days || create(:daysdef, short: num).days

      num = Faker::Number.between(1, 20)
      weeksdefs = Weeksdef.where(weeks: CardsRepositoryHelper.number_as_string(num.to_i))
      card.weeks = weeksdefs.first.weeks || create(:weeksdef, short: num).weeks
      card.terms = Termsdef.first.terms || create(:termsdef).terms
    end
    lesson

    after :create do |card|
      card.classrooms = card.lesson.classrooms
    end
  end
end
