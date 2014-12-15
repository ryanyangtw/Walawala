namespace :dev do
  
  desc "Calculate programz_count for every category"
  task :calculate_programz_count => :environment do
    Category.all.each do |c|
      #binding.pry


      # TODO (Note) counter cache is readonly. You should use reset_counters to update the initial datz
      Category.reset_counters(c.id, :programs)

      # Use update_attribute will present readonly error
      #c.update_attribute(:programz_count , c.programs.length)

      #c.update_attribute(:programz_count ,c.programs.length)

      #c.programz_count = c.programs.length
      #c.save
    end


  end




  desc "Calculate subscriberz_count for every program"
  task :calculate_subscriberz_count => :environment do
    Program.all.each do |p|
      p.update(:subscriberz_count => p.subscribers.length)
    end

  end


end