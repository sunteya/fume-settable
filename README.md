# Fume-Settable

a simple settings plugin for read on yaml, ruby, database, etc

## Installation

Add this line to your application's Gemfile:

	gem 'fume-settable'

Or install it yourself as:

	$ gem install fume-settable

## Usage

### 1. Define Class

#### `project.rb`
	class Project < Fume::Settable::Base
	  yaml_provider Rails.root.join("config/application.yml")      # yaml provider
	  ruby_provider Rails.root.join("config/application.local.rb") # ruby provider
	  append_providers ->(name) { "@lambda" if name == "lambda" }  # lambda provider
	  append_providers :fetch_on_method                            # method provider
	  mem_hash_provider                                            # mem hash provider
	  
	  def fetch_on_method(name)
	    "@method" if name == "method"
	  end
	end

#### `config/application.yml`
	yaml: @yaml

#### `config/application.local.rb`
	settings.ruby = "@ruby"

### 2. Run

	Project.settings.ruby        # return "@ruby"
	Project.settings.yaml        # return "@yaml"
	Project.settings.lambda      # return "@lambda"
	Project.settings.method      # return "@method"
	Project.settings.unknow      # return nil
	
	Project.settings.memhash     # return nil
	Project.settings.memhash = 1 # 
	Project.settings.memhash     # return 1

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
