
require './sql/sql'
require 'sequel'
require './model/models'

DB = Sequel.sqlite
Models.require_models   # "requires" up all app models
Client.test
Client.create_table!(DB)
Client.seed

=begin
Link.create_table!(DB)
Step.create_table!(DB)
Task.create_table!(DB)
User.create_table!(DB)




#- Users --------------------------------------------------------------------------|
beginning_user = User.create!(:name => 'Beginning User')
general_user = User.create!(:name => 'General User')
advanced_user = User.create!(:name => 'Advanced User')
junior_user = User.create!(:name => 'Junior User')
senior_user = User.create!(:name => 'Senior User')

junior_admin = User.create!(:name => 'Junior Administrator')
senior_admin = User.create!(:name => 'Senior Administrator')

junior_imp = User.create!(:name => 'Junior Implementer')
senior_imp = User.create!(:name => 'Senior Implementer')

junior_dev = User.create!(:name => 'Junior Developer')
senior_dev = User.create!(:name => 'Senior Developer')

junior_lead = User.create!(:name => 'Junior Leader')
senior_lead = User.create!(:name => 'Senior Leader')

junior_doc = User.create!(:name => 'Junior Documentation')
senior_doc = User.create!(:name => 'Senior Documentation')

junior_bus = User.create!(:name => 'Junior Business Consultant')
senior_bus = User.create!(:name => 'Senior Business Consultant')

junior_proj = User.create!(:name => 'Junior Project Leader')
senior_proj = User.create!(:name => 'Senior Project Leader')

#- root
Task.create!(:name => "Root", :point_id => junior_lead.id).tap do |root|
  Link.create!(:parent_id => nil, :task_id => root.id, :seq => 1)

  #- development
  Task.create!(:name => "Development", :point_id => junior_proj.id).tap do |project|
    Link.create!(:parent_id => root.id, :task_id => project.id, :seq => 1)
      #- task one
      Task.create!(:name => "New Development", :point_id => senior_dev.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 1)
      end
      #- task two
      Task.create!(:name => "Established Development", :point_id => senior_dev.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 2)
      end
      #- task three
      Task.create!(:name => "Cake work", :point_id => junior_dev.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 3)
      end
      #- task four
      Task.create!(:name => "Rough Stuff", :point_id => senior_dev.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 4)
      end
  end

  #- innovation
  Task.create!(:name => "Innovation", :point_id => junior_bus.id).tap do |project|
    Link.create!(:parent_id => root.id, :task_id => project.id, :seq => 2)
      #- task one
      Task.create!(:name => "New Innovation", :point_id => senior_lead.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 1)
      end
      #- task two
      Task.create!(:name => "Established Product Innovation", :point_id => senior_lead.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 2)
      end
      #- task three
      Task.create!(:name => "Cake", :point_id => junior_user.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 3)
      end
      #- task four
      Task.create!(:name => "Rough", :point_id => senior_user.id).tap do |task|
        Link.create!(:parent_id => project.id, :task_id => task.id, :seq => 4)
      end
  end
end
=end