#
# hash_to_repo_file.rb
#

module Puppet::Parser::Functions
  newfunction(:hash_to_repo_file, :type => :rvalue, :doc => <<-EOS
    Returns the filenames of yum repos to allow purging unused repos
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "hash_to_repo_file(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    repos = arguments[0]
    filenames = {}

    repos.each do |repo,value|
      filenames['/etc/yum.repos.d/' + repo + '.repo'] = {}
    end

    return filenames

  end
end
