# More info at https://github.com/guard/guard#readme
# JBL attempted to clean this up based on Hartl's (outdated) Github page - 8/27/2014
# https://github.com/railstutorial/sample_app_2nd_ed/blob/master/Guardfile

require 'active_support/inflector'
# this file added at the bottom with the guard init spork command,
# then moved up here
guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, 
               :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/environments/test.rb')
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
end

# add the cli clause here for spork
guard 'rspec', all_after_pass: false, cli: '--drb' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example

  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  # JBL put the block below on separate lines - don't know if this is kosher 
  # it's one line in Hartl
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", 
                                                          "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", 
                                                          "spec/acceptance/#{m[1]}_spec.rb"] }
  
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  # Hartl had another watch('spec/spec_helper.rb') { "spec" } here, but it seemed redundant
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  # Capybara request specs
  # This syntax (in the first line below) should use "features" per the book, 
  # but I substituted "requests" per the outdated Hartl on Github - which allowed guard to respond to changes
  # in the views/layouts/application.html.erb file
  # in the current setup, there is no "features" directory in spec/
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
  # JBL added this line to get the static_pages tests to run explicitly when the layout file changes
  watch('app/views/layouts/application.html.erb')     { "spec/requests/static_pages_spec.rb"}
  
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})    do |m|
                                                          ["spec/routing/#{m[1]}_routing_spec.rb",
                                                           "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
                                                           "spec/acceptance/#{m[1]}_spec.rb",
                                                           (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" :
                                                                             "spec/requests/#{m[1].singularize}_pages_spec.rb")]
                                                        end
  # The book does not have this line in the above block, but the Github page does:
  #   "spec/requests/#{m[1].singularize}_pages_spec.rb"

  watch(%r{^app/views/(.+)/})                           do |m|
                                                          (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" :
                                                                            "spec/requests/#{m[1].singularize}_pages_spec.rb")
                                                        end
                                                        
  # This line is in the Rails 4.0 book, but not on Hartl's github page:
  watch(%r{^app/controllers/sessions_controller\.rb$})  do |m|
                                                          "spec/requests/authentication_pages_spec.rb"
                                                        end
end

