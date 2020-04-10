class Ticket < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type

  before_create :full_capacity
  after_destroy :update_stats_destroy_ticket
  before_create :update_stats_create_ticket

  private
    def update_stats_create_ticket
      es = self.ticket_type.event.event_stat
      es.tickets_sold +=1
      es.attendance += 1
      es.save
    end

  private
    def update_stats_destroy_ticket
      es = self.ticket_type.event.event_stat
      es.tickets_sold -=1
      es.attendance -= 1
      es.save
    end

  private
  def full_capacity
    es = self.ticket_type.event.event_stat
    ev = self.ticket_type.event.event_venue
    if es.tickets_sold > ev.capacity
      puts "ERROR, TICKET SALE IS GREATER THAN THE PLACE CAPACITY!"
      es.tickets_sold -=1
      es.attendance -= 1
      es.save
    end
  end
end
