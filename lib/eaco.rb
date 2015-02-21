require 'eaco/error'
require 'eaco/version'

if defined? Rails
  require 'eaco/railtie'
end

require 'pathname'

# Welcome to Eaco!
#
# Eaco is a full-fledged authorization framework for Ruby that allows you to
# describe which actions are allowed on your resources, how to identify your
# users as having a particular privilege and which privileges are granted to
# a specific resource through the usage of ACLs.
#
module Eaco
  autoload :ACL,        'eaco/acl'
  autoload :Actor,      'eaco/actor'
  autoload :Adapters,   'eaco/adapters'
  autoload :DSL,        'eaco/dsl'
  autoload :Designator, 'eaco/designator'
  autoload :Resource,   'eaco/resource'

  # Parses and evaluates the authorization rules from
  #
  #   ./config/authorization.rb
  #
  # The authorization rules define all the authorization framework behaviour
  # through a DSL. Please see +Eaco::DSL+ and below for details.
  #
  # @return true
  # @raise  Eaco::Error if an error occurs during parsing.
  #
  def self.setup!
    rules = Pathname('./config/authorization.rb')

    unless rules.exist?
      raise Malformed, "Please create #{rules.realpath} with Eaco authorization rules"
    end

    DSL.send :eval, rules.read, nil, rules.realpath.to_s, 1

    true
  rescue => e
    raise Error, <<-EOF

=== EACO === Error while evaluating rules

#{e.message}

 +--------- -- -
 | #{e.backtrace.join("\n | ")}
 +-

=== EACO ===

    EOF
  end

end
