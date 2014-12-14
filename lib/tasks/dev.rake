namespace :dev do
  
  desc "Calculate programz_count for every category"
  task :calculate_programz_count => :environment do
    Category.all.each do |c|
      # Use update_attribute will present readonly error
      #c.update_attribute(:programz_count , c.programs.length)
      c.update_attributes(:programz_count => c.programs.length)
    end

  end




  desc "Calculate subscriberz_count for every program"
  task :calculate_subscriberz_count => :environment do
    Program.all.each do |p|
      p.update_attributes(:subscriberz_count => p.subscribers.length)
    end

  end


end